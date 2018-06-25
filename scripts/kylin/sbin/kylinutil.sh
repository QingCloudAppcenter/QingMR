#! /bin/bash

function checkHiveIsOK(){
	hivedefaultDB=$(/opt/hive/bin/hive -e "show databases;"|grep "default" |sed 's/ //g' )
	hiveIsOK="false"
	if [ "$hivedefaultDB"x == "default"x ]
	then
		hiveIsOK="true"
		echo $hiveIsOK
		exit 0
	fi
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - checkHiveIsOK : HIVE is not Runing!" 1>>$KYLINAPP_LOG  2>&1
	echo $hiveIsOK
}

function waitHiveReady(){
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Excute cmd: /opt/hive/bin/hive -e 'show databases;',to checkHiveIsOK." 1>>$KYLINAPP_LOG  2>&1
	i=1
	while [ ${i} -le 50 ]
	do
		hiveIsOK=$(checkHiveIsOK) 
		if [  "$hiveIsOK"x == "false"x ]
		then
			echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - waitHiveReady  : Waiting Hive to Start..." 1>>$KYLINAPP_LOG  2>&1
			sleep 10
		else
			break
		fi
		i=`expr ${i} + 1`
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - waitHiveReady : wait times=$i" 1>>$KYLINAPP_LOG  2>&1
	done

	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - waitHiveReady : Jump wait" 1>>$KYLINAPP_LOG  2>&1

	hiveIsOK=$(checkHiveIsOK)
	if [  "$hiveIsOK"x == "false"x ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - Error - waitHiveReady : Wait hive to start for 500s,but hive is still not running,kylin can not start." 1>>$KYLINAPP_LOG  2>&1
		isRunning="false"
	else
		isRunning="true"
	fi
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - isHiveRunning=$isRunning" 1>>$KYLINAPP_LOG  2>&1
	echo $isRunning
}

function StartKAP(){
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - user=`whoami`,StartKAP start" 1>>$KYLINAPP_LOG  2>&1 
	/opt/kap-plus/bin/kylin.sh start  1>>$KYLINAPP_LOG  2>&1 
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'`
	if [ "$pid"x == ""x ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - Error - StartKAP:Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1
		exit 1
	fi
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - StartKAP:Started Kylin Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function StartKyAnalyzer(){
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - user=`whoami`,StartKyAnalyzer start" 1>>$KYLINAPP_LOG  2>&1
	/opt/kyanalyzer/start-analyzer.sh  1>>$KYLINAPP_LOG  2>&1

	pid=`ps ax | grep kyanalyzer | grep -v grep  | awk '{print $1}'`
	if [ "$pid"x == ""x ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - Error - StartKyAnalyzer:Start kyanalyzer Service failed." 1>>$KYLINAPP_LOG  2>&1
		exit 1
	fi
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - StartKyAnalyzer:Started KyAnalyzer Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function StopKAP(){
	/opt/kap-plus/bin/kylin.sh stop  1>>$KYLINAPP_LOG  2>&1
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'`
	if [ "$pid"x != ""x ]
	then
		kill -9 $pid
		echo "`date '+%Y-%m-%d %H:%M:%S'`- kylinutil.sh - INFO - Stopped Kylin Service by killing pid=$pid." 1>>$KYLINAPP_LOG  2>&1
	fi
		echo "`date '+%Y-%m-%d %H:%M:%S'`- kylinutil.sh - INFO - Stopped Kylin Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function StopKyAnalyzer(){
	/opt/kyanalyzer/stop-analyzer.sh  1>>$KYLINAPP_LOG  2>&1
	pid=`ps ax | grep kyanalyzer | grep -v grep  | awk '{print $1}'`
	if [ "$pid"x != ""x ]
	then
		kill -9 $pid
		echo "`date '+%Y-%m-%d %H:%M:%S'`- kylinutil.sh - INFO - Stopped KyAnalyzer Service by killing pid=$pid." 1>>$KYLINAPP_LOG  2>&1
	fi
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Stoped KyAnalyzer Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function DealWithHDFS4Kylin(){
#Deal with HDFS
#if enable_kylin is true,for the first time it needs to create HDFS folder for kylin.
    #必须要用sudo去执行创建和修改hdfs目录的操作，否则在kylin用户下执行不成功。
    echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - hdfs dir info - =============================" 1>>$KYLINAPP_LOG  2>&1
	/opt/hadoop/bin/hadoop fs -ls /  1>>$KYLINAPP_LOG  2>&1

    sudo /opt/hadoop/bin/hadoop fs -chmod -R 777 /tmp   1>>$KYLINAPP_LOG  2>&1
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - sudo chmod hdfs -R 777 /tmp" 1>>$KYLINAPP_LOG  2>&1

	/opt/hadoop/bin/hadoop fs -test -e /kylin
	if [ $? -ne 0 ]
    then
    	sudo /opt/hadoop/bin/hadoop fs -mkdir /kylin  1>>$KYLINAPP_LOG  2>&1
    	sudo /opt/hadoop/bin/hadoop fs -chown kylin /kylin  1>>$KYLINAPP_LOG  2>&1
    	sudo /opt/hadoop/bin/hadoop fs -chmod -R 777 /kylin  1>>$KYLINAPP_LOG  2>&1
    	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - sudo Create hdfs dir /kylin" 1>>$KYLINAPP_LOG  2>&1
	fi


	/opt/hadoop/bin/hadoop fs -test -e /user
	if [ $? -ne 0 ]
    then
    	sudo /opt/hadoop/bin/hadoop fs -mkdir /user  1>>$KYLINAPP_LOG  2>&1
    	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - sudo Create hdfs dir /user" 1>>$KYLINAPP_LOG  2>&1
	fi

	/opt/hadoop/bin/hadoop fs -test -e /user/kylin
	if [ $? -ne 0 ]
    then
    	sudo /opt/hadoop/bin/hadoop fs -mkdir /user/kylin 1>>$KYLINAPP_LOG  2>&1
    	sudo /opt/hadoop/bin/hadoop fs -chown kylin /user/kylin  1>>$KYLINAPP_LOG  2>&1
    	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - sudo Create hdfs dir /user/kylin" 1>>$KYLINAPP_LOG  2>&1
	fi

	/opt/hadoop/bin/hadoop fs -test -e /user/hive
	if [ $? -ne 0 ]
	then
	    sudo /opt/hadoop/bin/hadoop fs -mkdir /user/hive 1>>$KYLINAPP_LOG  2>&1
	    sudo /opt/hadoop/bin/hadoop fs -chmod -R 777 /user/hive  1>>$KYLINAPP_LOG  2>&1
	    echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - sudo hadoop fs mkdir and chmod -R 777 /user/hive" 1>>$KYLINAPP_LOG  2>&1
	fi

	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - hdfs dir info - =============================" 1>>$KYLINAPP_LOG  2>&1
	/opt/hadoop/bin/hadoop fs -ls /  1>>$KYLINAPP_LOG  2>&1
	/opt/hadoop/bin/hadoop fs -ls /user  1>>$KYLINAPP_LOG  2>&1

}

function loadSampleData4Kylin(){
	/opt/kap-plus/bin/sample.sh     1>>$KYLINAPP_LOG  2>&1
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Excute cmd:/opt/kap-plus/bin/sample.sh" 1>>$KYLINAPP_LOG  2>&1
	touch  /opt/kap-plus/sbin/sample_loaded 
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Load sample data for kylin service init finished,create /opt/kap-plus/bin/sample_loadedFlag file." 1>>$KYLINAPP_LOG  2>&1
	
}

function action_start(){
	$(touch_ignore_healthcheck_file) 
 
	#change当前目录为kylin账号的home目录，因为在KAP的hdfs权限测试阶段会有在当前目录创建文件并上传到hdfs的操作，不切换到home目录会报无法创建测试目录。
	cd /home/kylin
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - change current path to /home/kylin." 1>>$KYLINAPP_LOG  2>&1 
	
	if [ ! -f "/opt/kap-plus/sbin/hdfsfolder_created" ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - DealWithHDFS4Kylin" 1>>$KYLINAPP_LOG  2>&1
		$(DealWithHDFS4Kylin)
	fi 
	
	/opt/kap-plus/sbin/j-start-kylin.sh
	if [  $? -ne 0 ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - Error -j-start-kylin.sh failed,Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1
		$(remove_ignore_healthcheck_file) 
		exit 1
	fi
 
	if [ ! -f "/opt/kap-plus/sbin/sample_loaded" ]
	then
		$(loadSampleData4Kylin)
	fi 
 
	$(remove_ignore_healthcheck_file)
}

function action_stop(){  
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'`
	if [ "$pid"x == ""x ]  
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - No running Kylin,no need to stop kylin." 1>>$KYLINAPP_LOG  2>&1  
		exit 0
	fi
	
	$(touch_ignore_healthcheck_file) 
	/opt/kap-plus/sbin/stop-kylin.sh  
	$(remove_ignore_healthcheck_file)
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Kylin Service already Stopped." 1>>$KYLINAPP_LOG  2>&1

}

function action_restart(){ 
	$(action_stop) 
		
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - user=`whoami`,sleep 10 seconds after stop then start." 1>>$KYLINAPP_LOG  2>&1
	sleep 10
		
	$(action_start) 	
}
 
function touch_ignore_healthcheck_file(){
	if [ ! -f "/home/kylin/ignore_healthcheck" ]
	then
		touch /home/kylin/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - add /home/kylin/ignore_healthcheck to ignore appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1
	fi
}

function remove_ignore_healthcheck_file(){
	if [  -f "/home/kylin/ignore_healthcheck" ]
	then
		rm /home/kylin/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - rm /home/kylin/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1
	fi
}

function remove_neverStartFlag_file(){
	if [  -f "/opt/kap-plus/sbin/neverStartFlag" ]
	then
		rm /opt/kap-plus/sbin/neverStartFlag
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - After cluster init, remove the neverStartFlag ." 1>>$KYLINAPP_LOG  2>&1
	fi
}















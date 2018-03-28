#! /bin/bash

function checkHiveIsRunning(){   
	for i in {1..500}
	do
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Excute cmd:/opt/hive/bin/hive -e 'show databases;'" 1>>$KYLINAPP_LOG  2>&1 
		/opt/hive/bin/hive -e "show databases;"  1>>$KYLINAPP_LOG  2>&1  
		if [  $? -ne 0 ] 
		then 
			echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - checkHiveIsRunning:Waiting Hive to Start..." 1>>$KYLINAPP_LOG  2>&1
			sleep 10
		else
			echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - checkHiveIsRunning:HIVE is Runing!" 1>>$KYLINAPP_LOG  2>&1
			break
		fi 
	done 
	
	/opt/hive/bin/hive -e "show databases;"  1>>$KYLINAPP_LOG  2>&1
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - Error - checkHiveIsRunning:Wait hive to start for 500s,but hive is still not running,kylin can not start." 1>>$KYLINAPP_LOG  2>&1  
		isRunning="false"
	else
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - checkHiveIsRunning:HIVE is Runing!" 1>>$KYLINAPP_LOG  2>&1
		isRunning="true"  
	fi 
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - isRunning=$isRunning" 1>>$KYLINAPP_LOG  2>&1
	echo $isRunning    
}

 

function StartKAP(){   
	USER=kylin /opt/kap-plus/bin/kylin.sh start  1>>$KYLINAPP_LOG  2>&1 
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'` 
	if [ "$pid"x == ""x ]
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - Error - StartKAP:Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1	 
		exit 1
	fi 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - StartKAP:Started Kylin Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function StartKyAnalyzer(){   
	USER=kylin /opt/kyanalyzer/start-analyzer.sh  1>>$KYLINAPP_LOG  2>&1 
	pid=`ps ax | grep kyanalyzer | grep -v grep  | awk '{print $1}'`
	if [ "$pid"x == ""x ]
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - Error - StartKyAnalyzer:Start kyanalyzer Service failed." 1>>$KYLINAPP_LOG  2>&1	 
		exit 1
	fi  
		echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - StartKyAnalyzer:Started KyAnalyzer Service successfully." 1>>$KYLINAPP_LOG  2>&1
}


function StopKAP(){   
	USER=kylin /opt/kap-plus/bin/kylin.sh stop   1>>$KYLINAPP_LOG  2>&1  
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'` 
	if [ "$pid"x != ""x ]
	then  
		kill -9 $pid
		echo "`date '+%Y-%m-%d %H:%M:%S'`- kylinutil.sh - INFO - Stopped Kylin Service by killing pid=$pid." 1>>$KYLINAPP_LOG  2>&1
	fi  
		echo "`date '+%Y-%m-%d %H:%M:%S'`- kylinutil.sh - INFO - Stopped Kylin Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function StopKyAnalyzer(){   
	USER=kylin /opt/kyanalyzer/stop-analyzer.sh  1>>$KYLINAPP_LOG  2>&1 
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
	hadoop fs -test -e /kylin
	if [ $? -ne 0 ]
    then  
    	hdfs dfs -mkdir /kylin  
    	hdfs dfs -chown kylin /kylin
    	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Create hdfs dir /kylin" 1>>$KYLINAPP_LOG  2>&1
	fi 
    	 
	hadoop fs -test -e /user
	if [ $? -ne 0 ]
    then  
    	hdfs dfs -mkdir /user
    	hdfs dfs -chown kylin /user
    	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Create hdfs dir /user" 1>>$KYLINAPP_LOG  2>&1
	fi 
	
	hadoop fs -test -e /user/kylin
	if [ $? -ne 0 ]
    then  
    	hdfs dfs -mkdir /user/kylin
    	hdfs dfs -chown kylin /user/kylin
    	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Create hdfs dir /user/kylin" 1>>$KYLINAPP_LOG  2>&1 
	fi   
	
	hdfs dfs -chmod -R 777 /tmp
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Chmod 777 hdfs dir /tmp" 1>>$KYLINAPP_LOG  2>&1 
	
	touch  /opt/kap-plus/sbin/hdfsfolder_created
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - DealWithHDFS4Kylin for kylin service init finished,create /opt/kap-plus/bin/sample_loaded Flag file." 1>>$KYLINAPP_LOG  2>&1
	  
}




function loadSampleData4Kylin(){ 
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Excute cmd: /opt/kap-plus/bin/sample.sh" 1>>$KYLINAPP_LOG  2>&1  
	/opt/kap-plus/bin/sample.sh   1>>$KYLINAPP_LOG  2>&1   
	touch  /opt/kap-plus/sbin/sample_loaded
	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - Load sample data for kylin service init finished,create /opt/kap-plus/bin/sample_loadedFlag file." 1>>$KYLINAPP_LOG  2>&1  
	
}







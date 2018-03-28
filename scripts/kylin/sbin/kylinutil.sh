#! /bin/bash

function checkHiveIsRunning(){   
	for i in {1..500}
	do 
		/opt/hive/bin/hive -e "show databases;"  1>>$KYLINAPP_LOG  2>&1  
		if [  $? -ne 0 ] 
		then 
			echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - INFO - checkHiveIsRunning:等待HIVE启动中..." 1>>$KYLINAPP_LOG  2>&1
			sleep 10
		else
			echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - INFO - checkHiveIsRunning:HIVE is Runing!" 1>>$KYLINAPP_LOG  2>&1
			break
		fi 
	done 
	
	/opt/hive/bin/hive -e "show databases;"  1>>$KYLINAPP_LOG  2>&1
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - Error - checkHiveIsRunning:Wait hive to start for 500s,but hive is still not running,kylin can not start." 1>>$KYLINAPP_LOG  2>&1  
		isRunning="false"
	else
		echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - INFO - checkHiveIsRunning:HIVE is Runing!" 1>>$KYLINAPP_LOG  2>&1
		isRunning="true"  
	fi 
	echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - INFO - isRunning=$isRunning" 1>>$KYLINAPP_LOG  2>&1
	echo $isRunning    
}

 

function StartKAP(){   
	USER=kylin /opt/kap-plus/bin/kylin.sh start  1>>$KYLINAPP_LOG  2>&1 
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'` 
	if [ "$pid"x == ""x ]
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - Error - StartKAP:Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1	 
		exit 1
	fi 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - INFO - StartKAP:Started Kylin Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function StartKyAnalyzer(){   
	USER=kylin /opt/kyanalyzer/start-analyzer.sh  1>>$KYLINAPP_LOG  2>&1 
	pid=`ps ax | grep kyanalyzer | grep -v grep  | awk '{print $1}'`
	if [ "$pid"x == ""x ]
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - Error - StartKyAnalyzer:Start kyanalyzer Service failed." 1>>$KYLINAPP_LOG  2>&1	 
		exit 1
	fi  
		echo "`date '+%Y-%m-%d %H:%M:%S'` - start-kylin.sh - INFO - StartKyAnalyzer:Started KyAnalyzer Service successfully." 1>>$KYLINAPP_LOG  2>&1
}


function StopKAP(){   
	USER=kylin /opt/kap-plus/bin/kylin.sh stop   1>>$KYLINAPP_LOG  2>&1  
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'` 
	if [ "$pid"x != ""x ]
	then  
		kill -9 $pid
		echo "`date '+%Y-%m-%d %H:%M:%S'`- stop-kylin.sh - INFO - Stopped Kylin Service by killing pid=$pid." 1>>$KYLINAPP_LOG  2>&1
	fi  
		echo "`date '+%Y-%m-%d %H:%M:%S'`- stop-kylin.sh - INFO - Stopped Kylin Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

function StopKyAnalyzer(){   
	USER=kylin /opt/kyanalyzer/stop-analyzer.sh  1>>$KYLINAPP_LOG  2>&1 
	pid=`ps ax | grep kyanalyzer | grep -v grep  | awk '{print $1}'`
	if [ "$pid"x != ""x ]
	then  	
		kill -9 $pid
		echo "`date '+%Y-%m-%d %H:%M:%S'`- stop-kylin.sh - INFO - Stopped KyAnalyzer Service by killing pid=$pid." 1>>$KYLINAPP_LOG  2>&1
	fi
	echo "`date '+%Y-%m-%d %H:%M:%S'` - stop-kylin.sh - INFO - Stoped KyAnalyzer Service successfully." 1>>$KYLINAPP_LOG  2>&1
}

#!/bin/bash  
source /etc/profile 
source /home/kylin/.profile
source /opt/kap-plus/sbin/kylinutil.sh  
 
action=$1  
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action Start ...." 1>>$KYLINAPP_LOG  2>&1

touch /root/ignore_healthcheck
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - add /root/ignore_healthcheck to ignore appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1 	 


if [ "$action"x == "start"x ]
then
	/opt/kap-plus/sbin/start-kylin.sh   
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error -exit code=$?, Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1	 
		exit 1  
	fi
	
	if [ ! -f "/opt/kap-plus/sbin/hdfsfolder_created" ]
	then
		#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - DealWithHDFS4Kylin Start. " 1>>$KYLINAPP_LOG  2>&1
		$(DealWithHDFS4Kylin)
		#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - DealWithHDFS4Kylin End. " 1>>$KYLINAPP_LOG  2>&1 
	fi
	
	if [ ! -f "/opt/kap-plus/sbin/sample_loaded" ]
	then
		#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - loadSampleData4Kylin Start. " 1>>$KYLINAPP_LOG  2>&1
		$(loadSampleData4Kylin)
		#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - loadSampleData4Kylin End. " 1>>$KYLINAPP_LOG  2>&1 
	fi
fi

if [ "$action"x == "stop"x ]
then 
	/opt/kap-plus/sbin/stop-kylin.sh
    echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Kylin Service already Stopped." 1>>$KYLINAPP_LOG  2>&1 	 
fi

if [ "$action"x == "restart"x ]
then
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - stop-kylin.sh." 1>>$KYLINAPP_LOG  2>&1  
	/opt/kap-plus/sbin/stop-kylin.sh   
	 
	sleep 5
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - sleep 5 seconds after stop kylin." 1>>$KYLINAPP_LOG  2>&1 
	
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - start-kylin.sh." 1>>$KYLINAPP_LOG  2>&1 
	
	#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Test============================================================." 1>>$KYLINAPP_LOG  2>&1
	#cat /opt/kap-plus/sbin/start-kylin.sh 1>>$KYLINAPP_LOG  2>&1
	#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Test============================================================." 1>>$KYLINAPP_LOG  2>&1
	
	/opt/kap-plus/sbin/start-kylin.sh  
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error -exit code=$?, Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1	 
		exit 1  
	fi 
	
fi 


rm /root/ignore_healthcheck
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /root/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1  
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1









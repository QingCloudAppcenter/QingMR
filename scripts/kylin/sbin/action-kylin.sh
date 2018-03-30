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
	/opt/kap-plus/sbin/j-start-kylin.sh   
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error -exit code=$?, Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1	
		rm /root/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /root/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1  
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1 
		exit 1  
	fi
	
	if [ ! -f "/opt/kap-plus/sbin/hdfsfolder_created" ]
	then 
		$(DealWithHDFS4Kylin) 
	fi
	
	if [ ! -f "/opt/kap-plus/sbin/sample_loaded" ]
	then 
		$(loadSampleData4Kylin) 
	fi
	
	if [  -f "/opt/kap-plus/sbin/neverStartFlag" ]
	then 
		rm /opt/kap-plus/sbin/neverStartFlag
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - After cluster init, remove the neverStartFlag when start service." 1>>$KYLINAPP_LOG  2>&1
	fi  
fi

if [ "$action"x == "stop"x ]
then 	
	/opt/kap-plus/sbin/stop-kylin.sh
    echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Kylin Service already Stopped." 1>>$KYLINAPP_LOG  2>&1  
fi

if [ "$action"x == "restart"x ]
then 
	pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'` 
	if [ "$pid"x == ""x ] && [ -f "/opt/kap-plus/sbin/neverStartFlag" ]
	then 
		if [ "$pid"x == ""x ] 
		then 
			echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - No running Kylin exits." 1>>$KYLINAPP_LOG  2>&1	
	    fi
	    
		if [  -f "/opt/kap-plus/sbin/neverStartFlag" ] 
		then 
			echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - found neverStartFlag." 1>>$KYLINAPP_LOG  2>&1	
	    fi
	
		rm /root/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /root/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1  
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1 
		exit 0
	fi
	
	  
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - execute script:stop-kylin.sh." 1>>$KYLINAPP_LOG  2>&1  
	/opt/kap-plus/sbin/stop-kylin.sh   
	  
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Stop kylin then start." 1>>$KYLINAPP_LOG  2>&1 
	
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - execute script:j-start-kylin.sh." 1>>$KYLINAPP_LOG  2>&1   
	/opt/kap-plus/sbin/j-start-kylin.sh  
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error -exit code=$?, Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1
		rm /root/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /root/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1  
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1	 
		exit 1  
	fi 
	
fi  


rm /root/ignore_healthcheck
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /root/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1  
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1









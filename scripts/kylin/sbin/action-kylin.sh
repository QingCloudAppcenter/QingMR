#!/bin/bash  
source /etc/profile
  
 
 
 
action=$1  
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action Start ...." 1>>$KYLINAPP_LOG  2>&1


if [ "$action"x == "start"x ]
then
	/opt/kap-plus/sbin/start-kylin.sh  
fi

if [ "$action"x == "stop"x ]
then 
    echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Kylin Service already Stopped." 1>>$KYLINAPP_LOG  2>&1 	 
fi

if [ "$action"x == "restart"x ]
then  
	/opt/kap-plus/sbin/stop-kylin.sh   
	 
	sleep 5
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Sleep 5 seconds after stop kylin." 1>>$KYLINAPP_LOG  2>&1 
	 
	/opt/kap-plus/sbin/start-kylin.sh  
fi 



echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1









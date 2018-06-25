#!/bin/bash  

export KYLINAPP_LOG=/opt/qingcloud/sbin/kylinapp.log    
echo "`date '+%Y-%m-%d %H:%M:%S'` - check-kylin-action.sh - INFO - Try to Start Kylin Start........." 1>>$KYLINAPP_LOG  2>&1; 
  
sudo -u kylin /opt/kap-plus/sbin/action-kylin.sh start
		
echo "`date '+%Y-%m-%d %H:%M:%S'` - check-kylin-action.sh - INFO - Try to Start Kylin End........." 1>>$KYLINAPP_LOG  2>&1; 
 

 
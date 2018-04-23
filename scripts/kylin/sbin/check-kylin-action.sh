#!/bin/bash 
source /etc/profile

    
echo "`date '+%Y-%m-%d %H:%M:%S'` - check-kylin-action.sh - INFO - Try to Start Kylin Start........." 1>>$KYLINAPP_LOG  2>&1;
/opt/kap-plus/sbin/action-kylin.sh start;
echo "`date '+%Y-%m-%d %H:%M:%S'` - check-kylin-action.sh - INFO - Try to Start Kylin End........." 1>>$KYLINAPP_LOG  2>&1; 
 

 
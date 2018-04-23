#!/bin/bash  
source /etc/profile
source /home/kylin/.profile 
source /opt/kap-plus/sbin/kylinutil.sh 


pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'` 

if [ "$pid"x == ""x ]
then 
    echo "`date '+%Y-%m-%d %H:%M:%S'` - stop-kylin.sh - INFO - Kylin Service is not running." 1>>$KYLINAPP_LOG  2>&1 
    exit 0	 
else
	#echo "`date '+%Y-%m-%d %H:%M:%S'` - stop-kylin.sh - INFO - StopKAP" 1>>$KYLINAPP_LOG  2>&1
	$(StopKAP) 
fi


pid=`ps ax | grep kyanalyzer | grep -v grep  | awk '{print $1}'`
if [ "$pid"x == ""x ]
then 
    echo "`date '+%Y-%m-%d %H:%M:%S'` - stop-kylin.sh - INFO - KyAnalyzer Service is not running." 1>>$KYLINAPP_LOG  2>&1 
    exit 0	 
else
	#echo "`date '+%Y-%m-%d %H:%M:%S'` - stop-kylin.sh - INFO - StopKyAnalyzer" 1>>$KYLINAPP_LOG  2>&1
	$(StopKyAnalyzer)
fi
 
echo "`date '+%Y-%m-%d %H:%M:%S'` - stop-kylin.sh - INFO - Stoped KAP and KyAnalyzer Service successfully." 1>>$KYLINAPP_LOG  2>&1 
exit 0



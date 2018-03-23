#!/bin/bash  
source /etc/profile
source /home/kylin/.profile  



USER=kylin /opt/kap-plus/bin/kylin.sh stop   1>>$KYLINAPP_LOG  2>&1  
pid=`ps ax | grep kylin | grep -v grep | grep -v 'su kylin' | grep -v 'bash' | grep 'Dkylin.hive.dependency' | awk '{print $1}'` 
if [ "$pid"x != ""x ]
then  
	kill -9 $pid
	echo "`date '+%Y-%m-%d %H:%M:%S'`- stop-kylin.sh - INFO - Stopped Kylin Service by killing pid=$pid." 1>>$KYLINAPP_LOG  2>&1
fi  
echo "`date '+%Y-%m-%d %H:%M:%S'`- stop-kylin.sh - INFO - Stopped Kylin Service successfully." 1>>$KYLINAPP_LOG  2>&1
	

USER=kylin /opt/kyanalyzer/stop-analyzer.sh  1>>$KYLINAPP_LOG  2>&1 
pid=`ps ax | grep kyanalyzer | grep -v grep  | awk '{print $1}'`
if [ "$pid"x != ""x ]
then  	
	kill -9 $pid
	echo "`date '+%Y-%m-%d %H:%M:%S'`- stop-kylin.sh - INFO - Stopped KyAnalyzer Service by killing pid=$pid." 1>>$KYLINAPP_LOG  2>&1
fi
echo "`date '+%Y-%m-%d %H:%M:%S'` - stop-kylin.sh - INFO - Stoped KyAnalyzer Service successfully." 1>>$KYLINAPP_LOG  2>&1

	
exit 0
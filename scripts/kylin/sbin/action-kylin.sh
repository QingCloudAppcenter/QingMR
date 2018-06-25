#!/bin/bash  
source /etc/profile
source /opt/kap-plus/sbin/kylinutil.sh

enable_kylin=$(curl -s http://metadata/self/env/enable_kylin)
#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - enable_kylin=$enable_kylin" 1>>$KYLINAPP_LOG  2>&1
 
if [ "$enable_kylin"x == "false"x ]
then
	echo " " 1>>$KYLINAPP_LOG  2>&1
	$(action_stop)
	$(remove_neverStartFlag_file)
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - enable_kylin=$enable_kylin,directly stop kylin and exit." 1>>$KYLINAPP_LOG  2>&1	
	echo " " 1>>$KYLINAPP_LOG  2>&1
	exit 0
fi 

 

#KAP使用的是自己的spark
export SPARK_HOME=$KYLIN_HOME/spark
#echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - SPARK_HOME=$SPARK_HOME" 1>>$KYLINAPP_LOG  2>&1

#/etc/rc.local 开启启动的时候才touch neverStartFlag
#neverStartFlag标识文件用于处理最初kylin.propetrties文件刷新reload是否需要restart kylin.
#如果集群是第一次启动，则让start执行，restart 退出。 



action=$1
echo " " 1>>$KYLINAPP_LOG  2>&1
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,SPARK_HOME=$SPARK_HOME,Action=$action Start ...." 1>>$KYLINAPP_LOG  2>&1

if [ "$action"x == "reload_kylinpro"x ]
then 
	if [  -f "/opt/kap-plus/sbin/neverStartFlag" ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - 第一次启动集群,要等action start 执行完，不执行restart" 1>>$KYLINAPP_LOG  2>&1
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1
	 	exit 0
	fi 
	$(action_restart)
	if [  $? -ne 0 ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error - action_restart failed,Restart Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1
		exit 1
	fi 
fi
  

if [ "$action"x == "start"x ]
then  
 	 $(action_start) 
	 
 	 if [  $? -ne 0 ]
	 then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error - action_start failed,Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1 
		$(remove_neverStartFlag_file)
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1
		exit 1
	 fi  
fi

if [ "$action"x == "stop"x ]
then 	
	$(action_stop)
	
	 if [  $? -ne 0 ]
	 then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error - action_stop failed,Stop Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1
		exit 1
	 fi 	
fi

if [ "$action"x == "restart"x ]
then 
	$(action_restart)
	
	if [  $? -ne 0 ]
	then
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error - action_restart failed,Restart Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1
		exit 1
	fi
fi   
    
$(remove_neverStartFlag_file) 
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1
echo " " 1>>$KYLINAPP_LOG  2>&1








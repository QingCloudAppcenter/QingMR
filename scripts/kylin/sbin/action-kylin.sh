#!/bin/bash  
source /etc/profile    
source /opt/kap-plus/sbin/kylinutil.sh    
 
export SPARK_HOME=$KYLIN_HOME/spark  
 
action=$1  

echo " " 1>>$KYLINAPP_LOG  2>&1
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action Start ...." 1>>$KYLINAPP_LOG  2>&1
 
touch /home/kylin/ignore_healthcheck
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - add /home/kylin/ignore_healthcheck to ignore appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1 	 
  
if [ "$action"x == "start"x ]
then  
 	enable_kylin=$(curl -s http://metadata/self/env/enable_kylin)
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - enable_kylin=$enable_kylin,SPARK_HOME=$SPARK_HOME" 1>>$KYLINAPP_LOG  2>&1
	
	if [ "$enable_kylin"x == "true"x ]
	then 
		#change当前目录为kylin账号的home目录，因为在KAP的hdfs权限测试阶段会有在当前目录创建文件并上传到hdfs的操作，不切换到home目录会报无法创建测试目录。
		cd /home/kylin
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - change current path to /home/kylin." 1>>$KYLINAPP_LOG  2>&1
		
		if [ ! -f "/opt/kap-plus/sbin/hdfsfolder_created" ]
		then  
			$(DealWithHDFS4Kylin) 
		fi 
	fi
	
	
	/opt/kap-plus/sbin/j-start-kylin.sh   
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error -j-start-kylin.sh failed,Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1	
		rm /home/kylin/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /home/kylin/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1 
		
		if [  -f "/opt/kap-plus/sbin/neverStartFlag" ]
		then 
			rm /opt/kap-plus/sbin/neverStartFlag
			echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - After cluster init, remove the neverStartFlag when start service." 1>>$KYLINAPP_LOG  2>&1
		fi
			 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1		
		exit 1  
	fi 
	
	
	if [ "$enable_kylin"x == "true"x ]
	then
		/opt/hadoop/bin/hadoop fs -test -e /user/hive
		if [ $? -eq 0 ]
	    then
	    	sudo /opt/hadoop/bin/hadoop fs -mkdir /user/hive 1>>$KYLINAPP_LOG  2>&1   
	    	sudo /opt/hadoop/bin/hadoop fs -chmod -R 777 /user/hive  1>>$KYLINAPP_LOG  2>&1 
	    	echo "`date '+%Y-%m-%d %H:%M:%S'` - kylinutil.sh - INFO - sudo hadoop fs mkdir and chmod -R 777 /user/hive" 1>>$KYLINAPP_LOG  2>&1 
		fi 
				
		if [ ! -f "/opt/kap-plus/sbin/sample_loaded" ]
		then 
			$(loadSampleData4Kylin) 
		fi 
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
	
		rm /home/kylin/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /home/kylin/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1  
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1 		
		exit 0
	fi
	
	  
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - execute script:stop-kylin.sh." 1>>$KYLINAPP_LOG  2>&1  
	/opt/kap-plus/sbin/stop-kylin.sh   
	  
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - Stop kylin then start." 1>>$KYLINAPP_LOG  2>&1 
	
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - execute script:j-start-kylin.sh." 1>>$KYLINAPP_LOG  2>&1   
	/opt/kap-plus/sbin/j-start-kylin.sh  
	if [  $? -ne 0 ] 
	then 
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - Error - Start Kylin Service failed." 1>>$KYLINAPP_LOG  2>&1
		rm /home/kylin/ignore_healthcheck
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /home/kylin/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1
		echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1	 		
		exit 1  
	fi  
fi  



rm /home/kylin/ignore_healthcheck
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - rm /home/kylin/ignore_healthcheck to recovery appcenter healthcheck. " 1>>$KYLINAPP_LOG  2>&1  

if [  -f "/opt/kap-plus/sbin/neverStartFlag" ]
then 
	rm /opt/kap-plus/sbin/neverStartFlag
	echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - After cluster init, remove the neverStartFlag when start service." 1>>$KYLINAPP_LOG  2>&1
fi

 
echo "`date '+%Y-%m-%d %H:%M:%S'` - action-kylin.sh - INFO - user=`whoami`,user=`whoami`,Action=$action End ...." 1>>$KYLINAPP_LOG  2>&1
echo " " 1>>$KYLINAPP_LOG  2>&1








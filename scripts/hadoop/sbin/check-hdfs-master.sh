#!/usr/bin/env bash

HADOOP_HOME="/opt/hadoop"
HADOOP_LOG_PATH="/data/hadoop/logs"

ret_val=0
nn_pid=`ps ax | grep proc_namenode | grep -v grep | awk '{print $1}'`
if [ "x$nn_pid" = "x" ]; then
    echo "Name node is not running!"
    ret_val=$[$ret_val + 1]
fi

snn_pid=`ps ax | grep secondarynamenode | grep -v grep | awk '{print $1}'`
if [ "x$snn_pid" = "x" ];then
    echo "Secondary name node is not running!"
    ret_val=$[$ret_val + 2]
fi

js_pid=`ps ax | grep historyserver | grep -v grep | awk '{print $1}'`
if [ "x$js_pid" = "x" ];then
    echo "flink historyserver is not running!"
    ret_val=$[$ret_val + 3]
fi

HM=`date -d "now" +%H%M`
if [ $HM -eq "0200" ];then
    find $HADOOP_LOG_PATH -type f -mtime +7 -name "hadoop-root-*" -delete
fi

sh /opt/flink/sbin/check-flink-completed-jobs.sh

exit $ret_val

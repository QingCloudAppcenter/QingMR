#!/usr/bin/env bash

HADOOP_HOME="/opt/hadoop"
HADOOP_LOG_PATH="/data/hadoop/logs"
FLINK_HOME='/opt/flink'

nn_pid=`ps ax | grep proc_namenode | grep -v grep | awk '{print $1}'`
if [ "x$nn_pid" = "x" ]; then
    echo "Trying to start name node..."
    USER=root $HADOOP_HOME/sbin/hadoop-daemon.sh start namenode 
fi

snn_pid=`ps ax | grep secondarynamenode | grep -v grep | awk '{print $1}'`
if [ "x$snn_pid" = "x" ];then
    echo "Trying to start secondary name node..."
    USER=root $HADOOP_HOME/sbin/hadoop-daemon.sh start secondarynamenode
fi

js_pid=`ps ax | grep historyserver | grep -v grep | awk '{print $1}'`
if [ "x$js_pid" = "x" ];then
    echo "Trying to start flink historyserver..."
    USER=root $FLINK_HOME/sbin/start-historyserver.sh
fi

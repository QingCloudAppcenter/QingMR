#!/usr/bin/env bash

SPARK_HOME="/opt/spark"

sk_pid=`ps ax | grep 'spark.*Master' | grep -v grep | awk '{print $1}'`
if [ "x$sk_pid" = "x" ]; then
    echo "Trying to start name node..."
    USER=root $SPARK_HOME/sbin/start-master.sh
fi

livy_pid=`ps ax | grep 'LivyServer' | grep -v grep | awk '{print $1}'`
if [ "x$livy_pid" = "x" ]; then
    echo "Trying to start LivyServer..."
    USER=root /opt/livy/bin/livy-server start
fi

#!/usr/bin/env bash

export JAVA_HOME=/usr/jdk
export FLINK_HOME=/opt/flink
export HADOOP_HOME=/opt/hadoop

flink_log="/data/flink/log/"
CONF_FILE="${FLINK_HOME}/conf/flink-conf.yaml"

if [ ! -d "$flink_log" ]
then
    mkdir -p "$flink_log"
fi

jd=$(cat $CONF_FILE | grep jobmanager.archive.fs.dir | awk -F: '{print $3}' | cut -c 3-)
hadoop fs -test -e $jd
if [ $? -ne 0 ]; then
    hadoop fs -mkdir -p $jd
fi

USER=root $FLINK_HOME/bin/historyserver.sh start

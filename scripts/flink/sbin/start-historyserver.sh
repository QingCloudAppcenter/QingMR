#!/usr/bin/env bash

export JAVA_HOME=/usr/jdk
export FLINK_HOME=/opt/flink
export HADOOP_HOME=/opt/hadoop

flink_log="/data/flink/log/"
CONF_FILE="${FLINK_HOME}/conf/flink-conf.yaml"

logdir=$(cat $CONF_FILE | grep env.log.dir | sed s/[[:space:]]//g | awk -F: '{print $2}')
if [ ! -d "$logdir" ]
then
    mkdir -p "$logdir"
fi

jd=$(cat $CONF_FILE | grep jobmanager.archive.fs.dir | awk -F: '{print $3}' | cut -c 3-)
$HADOOP_HOME/bin/hadoop fs -test -e $jd
if [ $? -ne 0 ]; then
    $HADOOP_HOME/bin/hadoop fs -mkdir -p $jd
    $HADOOP_HOME/bin/hadoop fs -chmod 777 $jd
fi

$HADOOP_HOME/bin/hadoop fs -test -e $jd
if [ $? -ne 0 ]; then
  exit 1
fi

USER=root $FLINK_HOME/bin/historyserver.sh start
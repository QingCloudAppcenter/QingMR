#!/usr/bin/env bash

export JAVA_HOME=/usr/jdk11
export FLINK_HOME=/opt/flink
export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$FLINK_HOME/bin:$PATH

export HADOOP_CLASSPATH=$($HADOOP_HOME/bin/hadoop classpath)

mkdir -p /data/flink/history
mkdir -p /data/flink/web
mkdir -p /data/flink/log

CONF_FILE="${FLINK_HOME}/conf/flink-conf.yaml"

logdir=$(cat $CONF_FILE | grep env.log.dir | sed s/[[:space:]]//g | awk -F: '{print $2}')
if [ ! -d "$logdir" ]
then
    mkdir -p "$logdir"
fi

jd=$(cat $CONF_FILE | grep jobmanager.archive.fs.dir | awk -F: '{print $3}' | cut -c 3-)
$HADOOP_HOME/bin/hdfs dfs -test -e $jd
if [ $? -ne 0 ]; then
    $HADOOP_HOME/bin/hdfs dfs -mkdir -p $jd
    $HADOOP_HOME/bin/hdfs dfs -chmod 777 $jd
fi

$HADOOP_HOME/bin/hdfs dfs -test -e $jd
if [ $? -ne 0 ]; then
  exit 1
fi

USER=root $FLINK_HOME/bin/historyserver.sh start

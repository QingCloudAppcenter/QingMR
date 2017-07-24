#!/usr/bin/env bash
export JAVA_HOME=/usr/jdk
USER=root /opt/hadoop/bin/hdfs dfs -get /tmp/hadoop-yarn/*-scheduler.xml /opt/hadoop/etc/
USER=root mv -f /opt/hadoop/etc/*-scheduler.xml /opt/hadoop/etc/hadoop/
exit 0

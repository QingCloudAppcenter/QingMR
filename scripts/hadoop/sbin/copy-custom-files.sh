#!/usr/bin/env bash
/opt/hadoop/bin/hdfs dfs -get /tmp/hadoop-yarn/*-scheduler.xml /opt/hadoop/etc/hadoop/ 2>/dev/null
exit 0

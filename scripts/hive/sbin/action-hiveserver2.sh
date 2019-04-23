#!/bin/bash
pid=`ps ax | grep HiveServer2 | grep -v grep | awk '{print $1}'`
if [ "x$pid" = "x" ]; then
    echo "Trying to start HiveServer2..."
    # for hive tmp dir
    HIVE_DIR=/data/hive
    if [ ! -d $HIVE_DIR ]; then
        mkdir -p $HIVE_DIR
        chown hive:hive $HIVE_DIR
    fi
    nohup sudo -u hive /opt/hive/sbin/start-hiveserver2.sh &>/dev/null
fi
exit $?
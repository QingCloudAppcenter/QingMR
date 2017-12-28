#!/bin/bash
pid=`ps ax | grep HiveServer2 | grep -v grep | awk '{print $1}'`
if [ "x$pid" = "x" ]; then
    echo "Trying to start HiveServer2..."
    sudo -u hive /opt/hive/sbin/start-hiveserver2.sh
fi
exit $?
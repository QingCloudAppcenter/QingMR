#!/bin/bash
pid=`ps ax | grep mysqld | grep -v grep | awk '{print $1}'`
if [ "x$pid" = "x" ]; then
    echo "Trying to start mysql..."
    /opt/hive/sbin/start-mysql.sh
fi
exit $?
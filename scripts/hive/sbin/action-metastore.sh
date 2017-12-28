#!/bin/bash
pid=`ps ax | grep HiveMetaStore | grep -v grep | awk '{print $1}'`
if [ "x$pid" = "x" ]; then
    echo "Trying to start HiveMetaStore..."
    sudo -u hive /opt/hive/sbin/start-metastore.sh
fi
exit $?
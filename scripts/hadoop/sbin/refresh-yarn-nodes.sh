#!/bin/sh
# /opt/hadoop/sbin/refresh-yarn-nodes.sh
pid=`ps ax | grep java | grep ResourceManager | grep -v grep| awk '{print $1}'`
if [ "x$pid" = "x" ]
then
    exit 0
else
    USER=root /opt/hadoop/bin/yarn rmadmin -refreshNodes
fi

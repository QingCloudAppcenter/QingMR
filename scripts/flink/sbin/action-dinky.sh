#!/usr/bin/env bash

pid=`ps ax | grep dinky | grep -v grep | grep -v action | awk '{print $1}'`
if [ "x$pid" = "x" ]; then
    echo "Trying to start dinky..."
    nohup sudo /opt/dinky/bin/auto.sh start 1.19 &>/dev/null
fi
exit $?


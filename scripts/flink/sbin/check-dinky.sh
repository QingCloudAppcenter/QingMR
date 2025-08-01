#!/usr/bin/env bash

ret_val=0
pid=`ps ax | grep dinky | grep -v grep | grep -v check | awk '{print $1}'`
if [ "x$pid" = "x" ]; then
    echo "dinky is not running!"
    ret_val=$[$ret_val + 1]
fi
exit $ret_val
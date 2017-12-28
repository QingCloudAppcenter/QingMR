#!/bin/bash
ret_val=0
pid=`ps ax | grep HiveMetaStore | grep -v grep | awk '{print $1}'`
if [ "x$pid" = "x" ]; then
    echo "HiveMetaStore is not running!"
    ret_val=$[$ret_val + 1]
fi
exit $ret_val

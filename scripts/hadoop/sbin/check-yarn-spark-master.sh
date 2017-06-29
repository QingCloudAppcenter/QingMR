#!/usr/bin/env bash

ret_spark=0
ret_yarn=0

/opt/spark/sbin/check-spark-master.sh
ret_spark=$?

/opt/hadoop/sbin/check-yarn-master.sh
ret_yarn=$?

ret_val=$[$ret_spark + 100*$ret_yarn]

exit $ret_val

#!/usr/bin/env bash
ret_spark=0
ret_yarn=0
ret_mysql=0
ret_metastore=0
ret_hiveserver2=0

/opt/spark/sbin/action-spark-master.sh
ret_spark=$?

/opt/hadoop/sbin/action-yarn-master.sh
ret_yarn=$?

/opt/mysql/sbin/action-mysql.sh
ret_mysql=$?

/opt/hive/sbin/action-metastore.sh
ret_metastore=$?

/opt/hive/sbin/action-hiveserver2.sh
ret_hiveserver2=$?

/opt/flink/sbin/action-dinky.sh
ret_dinky=$?

ret_val=$[$ret_spark + 10*$ret_yarn + 100*$ret_mysql + 200*$ret_metastore + 1000*$ret_hiveserver2 + 10000*$ret_dinky]
exit $ret_val

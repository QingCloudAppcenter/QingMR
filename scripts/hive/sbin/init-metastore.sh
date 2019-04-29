#!/bin/bash
# use schematool to init schema metadata in mysql about hive
export HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}
export HIVE_HOME=${HIVE_HOME:-"/opt/hive"}
stool=$HIVE_HOME/bin/schematool
$stool -dbType mysql -validate
if [ $? -ne 0 ]; then
    $stool -dbType mysql -initSchema
    if [ $? -ne 0 ]; then
        echo `date '+%Y-%m-%d %H:%M:%S'` - init-metastore.sh - Error - failed to init hive schema metadata in mysql.
        exit 1
    fi
fi

exit 0
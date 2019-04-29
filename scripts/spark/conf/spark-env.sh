#! /bin/bash
export JAVA_HOME=/usr/jdk
export HADOOP_HOME=/opt/hadoop
export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native
export SPARK_DIST_CLASSPATH=$(${HADOOP_HOME}/bin/hadoop classpath | sed 's/\/opt\/hadoop.\{,6\}\/etc\/hadoop//')
source /opt/spark/conf/spark-env-custom.sh
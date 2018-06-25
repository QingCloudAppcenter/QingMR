#! /bin/bash
export JAVA_HOME=/usr/jdk
export HADOOP_HOME=/opt/hadoop
export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native
source /opt/spark/conf/spark-env-custom.sh
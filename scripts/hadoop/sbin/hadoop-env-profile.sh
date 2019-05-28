#! /bin/bash
export JAVA_HOME=/usr/jdk
export PATH=$JAVA_HOME/bin:$PATH
export HADOOP_HOME=/opt/hadoop 
export HIVE_HOME=/opt/hive
export SQOOP_HOME=/opt/sqoop 
 
export PATH=${HADOOP_HOME}/bin:${HIVE_HOME}/bin:${SQOOP_HOME}/bin:$PATH
export HADOOP_S3=/opt/hadoop/share/hadoop/tools/lib/hadoop-aws-2.9.2.jar,/opt/hadoop/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.199.jar,/opt/hadoop/share/hadoop/tools/lib/jackson-annotations-2.7.8.jar,/opt/hadoop/share/hadoop/tools/lib/jackson-core-2.7.8.jar,/opt/hadoop/share/hadoop/tools/lib/jackson-core-asl-1.9.13.jar,/opt/hadoop/share/hadoop/tools/lib/jackson-databind-2.7.8.jar,/opt/hadoop/share/hadoop/tools/lib/jackson-jaxrs-1.9.13.jar,/opt/hadoop/share/hadoop/tools/lib/jackson-mapper-asl-1.9.13.jar,/opt/hadoop/share/hadoop/tools/lib/jackson-xc-1.9.13.jar
export SPARK_S3=/opt/hadoop/share/hadoop/tools/lib/hadoop-aws-2.9.2.jar,/opt/hadoop/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.199.jar
 
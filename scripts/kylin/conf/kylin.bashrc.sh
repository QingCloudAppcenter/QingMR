export JAVA_HOME=/usr/jdk
export PATH=$JAVA_HOME/bin:$PATH
export HADOOP_HOME=/opt/hadoop 
export HIVE_HOME=/opt/hive
export SQOOP_HOME=/opt/sqoop
export KYLIN_HOME=/opt/kap-plus
 
export SPARK_HOME=$KYLIN_HOME/spark

export PATH=${HADOOP_HOME}/bin:${HIVE_HOME}/bin:${SQOOP_HOME}/bin:${SPARK_HOME}/bin:$PATH
export HADOOP_S3=/opt/hadoop/share/hadoop/common/lib/hadoop-aws-2.7.3.jar,/opt/hadoop/share/hadoop/common/lib/aws-java-sdk-1.7.4.jar,/opt/hadoop/share/hadoop/common/lib/jackson-annotations-2.2.3.jar,/opt/hadoop/share/hadoop/common/lib/jackson-core-2.2.3.jar,/opt/hadoop/share/hadoop/common/lib/jackson-core-asl-1.9.13.jar,/opt/hadoop/share/hadoop/common/lib/jackson-databind-2.2.3.jar,/opt/hadoop/share/hadoop/common/lib/jackson-jaxrs-1.9.13.jar,/opt/hadoop/share/hadoop/common/lib/jackson-mapper-asl-1.9.13.jar,/opt/hadoop/share/hadoop/common/lib/jackson-xc-1.9.13.jar
export SPARK_S3=/opt/hadoop/share/hadoop/common/lib/hadoop-aws-2.7.3.jar,/opt/hadoop/share/hadoop/common/lib/aws-java-sdk-1.7.4.jar



 
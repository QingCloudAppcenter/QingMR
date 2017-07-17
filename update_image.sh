#!/bin/bash
role=$1
if [ $# -lt 1 ];then
    echo error!
else
    cp -r confd/$role/conf.d /etc/confd/
    cp -r confd/$role/templates /etc/confd/
    cp -r scripts/hadoop/sbin /opt/hadoop/
    cp -r scripts/spark/sbin /opt/spark/
    cp jars/S3/* /opt/hadoop/share/hadoop/common/lib/
    if [ "x$role" = "xbigdata-client" ];then
    	cp jars/mysql-connector-java-5.1.39-bin.jar /opt/hive/lib/
    fi
    #tar -xvzf hadoop-2.7.3-build.tar.gz -C /opt/
    #rm /opt/hadoop
    #ln -s /opt/hadoop-2.7.3 /opt/hadoop
    #tar -xvzf spark-2.2.0-bin-hadoop2.7.tgz -C /opt/
    #rm /opt/spark
    #ln -s /opt/spark-2.2.0-bin-hadoop2.7 /opt/spark
fi

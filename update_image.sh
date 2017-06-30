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
fi

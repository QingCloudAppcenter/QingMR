#!/bin/bash
role=$1
package=$2
if [ $# -lt 1 ];then
    echo error!
else
    #make base image
    if [ "x$role" = "xtemplate" ];then
    	tar -xvzf hadoop-2.7.3.tar.gz -C /opt/
    	rm /opt/hadoop
    	ln -s /opt/hadoop-2.7.3 /opt/hadoop

    	tar -xvzf spark-2.2.0-bin-hadoop2.7.tgz -C /opt/
    	tar -xvzf spark-2.1.1-bin-hadoop2.7.tgz -C /opt/
    	tar -xvzf spark-2.0.2-bin-hadoop2.7.tgz -C /opt/
    	rm /opt/spark
    	ln -s /opt/spark-2.2.0-bin-hadoop2.7 /opt/spark
    	cp /opt/spark-2.2.0-bin-hadoop2.7/conf/spark-defaults.conf.template /opt/spark-2.2.0-bin-hadoop2.7/conf/spark-defaults.conf
    	cp /opt/spark-2.1.1-bin-hadoop2.7/conf/spark-defaults.conf.template /opt/spark-2.1.1-bin-hadoop2.7/conf/spark-defaults.conf
    	cp /opt/spark-2.0.2-bin-hadoop2.7/conf/spark-defaults.conf.template /opt/spark-2.0.2-bin-hadoop2.7/conf/spark-defaults.conf

    	tar -xvzf jdk-8u141-linux-x64.tar.gz -C /usr/
    	ln -s /usr/jdk1.8.0_141 /usr/jdk

    	tar -xvzf miniconda.tar.gz -C /opt/
    	ln -s /opt/miniconda2/ /opt/python2
    	ln -s /opt/miniconda3/ /opt/python3

    	tar -xvzf livy-server-0.2.0.tar.gz -C /opt/
    	ln -s /opt/livy-server-0.2.0/ /opt/livy

    	tar -xvzf bigdata-client.tar.gz -C /opt/
    	ln -s /opt/apache-hive-1.2.2-bin/ /opt/hive
    	ln -s /opt/sqoop-1.4.6.bin__hadoop-2.0.4-alpha/ /opt/sqoop

    	chown -R root:root /opt/
    else
    	cp -r confd/$role/conf.d /etc/confd/
    	cp -r confd/$role/templates /etc/confd/
    	cp -r scripts/hadoop/etc /opt/hadoop/
    	cp -r scripts/hadoop/sbin /opt/hadoop/
    	cp -r scripts/spark/sbin /opt/spark/
    	cp jars/S3/* /opt/hadoop/share/hadoop/common/lib/
    fi

    if [ "x$role" = "xbigdata-client" ];then
    	cp jars/mysql-connector-java-5.1.39-bin.jar /opt/hive/lib/
    fi

    if [ "x$package" = "xlzo" ];then
	tar -xvzf lzo/libgplcompression.tar.gz -C /opt/hadoop/lib/native/
	mv /opt/hadoop/lib/native/libgplcompression/* /opt/hadoop/lib/native/
	rm -rf /opt/hadoop/lib/native/libgplcompression/

	tar -xvzf lzo/liblzo.tar.gz -C /usr/lib/
	mkdir -p /usr/lib64/
	tar -xvzf lzo/liblzo.tar.gz -C /usr/lib64/

	cp lzo/lzop /usr/local/bin/lzop;
	rm -rf /usr/bin/lzop
	ln -s /usr/local/bin/lzop /usr/bin/lzop

	cp lzo/hadoop-lzo-0.4.20.jar /opt/hadoop/share/hadoop/common/
    fi
fi

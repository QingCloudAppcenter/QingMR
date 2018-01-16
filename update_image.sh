#!/bin/bash
server=$1
role=$2
package=$3
if [ $# -lt 2 ];then
    echo error!
else
    #make base image
    if [ "x$role" = "xtemplate" ];then
		#scp image/*.tar.gz $server:/opt/"
		#scp -r image/lzo $server:/opt/"
    	#ssh $server "tar -xvzf /opt/hadoop-2.7.3.tar.gz -C /opt/"
    	#ssh $server "rm /opt/hadoop"
    	#ssh $server "ln -s /opt/hadoop-2.7.3 /opt/hadoop"
    	#scp jars/S3/* $server:/opt/hadoop/share/hadoop/common/lib/

		#ssh $server "tar -xvzf /opt/apache-hive-1.2.2-bin.tar.gz -C /opt/"
    	#ssh $server "rm /opt/hive"
    	#ssh $server "ln -s /opt/apache-hive-1.2.2-bin /opt/hive"
		#scp jars/mysql-connector-java-5.1.45-bin.jar /opt/hive/lib/

    	#ssh $server "tar -xvzf /opt/spark-2.2.0-bin-hadoop2.7.tgz -C /opt/"
    	#ssh $server "tar -xvzf /opt/spark-2.1.1-bin-hadoop2.7.tgz -C /opt/"
    	#ssh $server "tar -xvzf /opt/spark-2.0.2-bin-hadoop2.7.tgz -C /opt/"
    	#ssh $server "rm /opt/spark"
    	#ssh $server "ln -s /opt/spark-2.2.0-bin-hadoop2.7 /opt/spark"
    	#ssh $server "cp /opt/spark-2.2.0-bin-hadoop2.7/conf/spark-defaults.conf.template /opt/spark-2.2.0-bin-hadoop2.7/conf/spark-defaults.conf"
    	#ssh $server "cp /opt/spark-2.1.1-bin-hadoop2.7/conf/spark-defaults.conf.template /opt/spark-2.1.1-bin-hadoop2.7/conf/spark-defaults.conf"
    	#ssh $server "cp /opt/spark-2.0.2-bin-hadoop2.7/conf/spark-defaults.conf.template /opt/spark-2.0.2-bin-hadoop2.7/conf/spark-defaults.conf"

    	#ssh $server "tar -xvzf /opt/jdk-8u141-linux-x64.tar.gz -C /usr/"
    	#ssh $server "ln -s /usr/jdk1.8.0_141 /usr/jdk"

    	#ssh $server "tar -xvzf /opt/miniconda.tar.gz -C /opt/"
    	#ssh $server "ln -s /opt/miniconda2/ /opt/python2"
    	#ssh $server "ln -s /opt/miniconda3/ /opt/python3"

    	#ssh $server "tar -xvzf /opt/livy-server-0.2.0.tar.gz -C /opt/"
    	#ssh $server "ln -s /opt/livy-server-0.2.0/ /opt/livy"

    	#ssh $server "tar -xvzf /opt/bigdata-client.tar.gz -C /opt/"
    	#ssh $server "ln -s /opt/apache-hive-1.2.2-bin/ /opt/hive"
    	#ssh $server "ln -s /opt/sqoop-1.4.6.bin__hadoop-2.0.4-alpha/ /opt/sqoop"

		echo "template image created"
	else
		ssh $server "apt-get install -y ntp"
    	scp -r confd/$role/conf.d $server:/etc/confd/
    	scp -r confd/$role/templates $server:/etc/confd/
    	scp -r scripts/hadoop/etc $server:/opt/hadoop/
    	scp -r scripts/hadoop/sbin $server:/opt/hadoop/
    	scp -r scripts/spark/sbin $server:/opt/spark/
		scp -r scripts/hive/sbin $server:/opt/hive/
		scp -r scripts/qingcloud/sbin $server:/opt/qingcloud/
		scp -r scripts/etc/ntp.conf $server:/opt/etc/
    fi

    if [ "x$role" = "xbigdata-client" ] || [ "x$role" = "xyarn-master" ];then
    	scp jars/mysql-connector-java-5.1.45-bin.jar $server:/opt/hive/lib/
    fi

    if [ "x$package" = "xlzo" ];then
		ssh $server "tar -xvzf /opt/lzo/libgplcompression.tar.gz -C /opt/hadoop/lib/native/"
		ssh $server "mv /opt/hadoop/lib/native/libgplcompression/* /opt/hadoop/lib/native/"
		ssh $server "rm -rf /opt/hadoop/lib/native/libgplcompression/"

		ssh $server "tar -xvzf /opt/lzo/liblzo.tar.gz -C /usr/lib/"
		ssh $server "mkdir -p /usr/lib64/"
		ssh $server "tar -xvzf /opt/lzo/liblzo.tar.gz -C /usr/lib64/"

		ssh $server "cp /opt/lzo/lzop /usr/local/bin/lzop;"
		ssh $server "rm -rf /usr/bin/lzop"
		ssh $server "ln -s /usr/local/bin/lzop /usr/bin/lzop"

		ssh $server "cp /opt/lzo/hadoop-lzo-0.4.20.jar /opt/hadoop/share/hadoop/common/"
		ssh $server "sudo chown -R root:root /usr/lib/"
		ssh $server "sudo chown -R root:root /usr/lib64/"
		ssh $server "sudo chown -R root:root /opt/"
    fi
	#ssh $server "rm /opt/*.tar.gz"
	#ssh $server "rm -rf /opt/lzo"
fi

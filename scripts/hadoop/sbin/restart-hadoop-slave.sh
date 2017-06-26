#! /bin/sh
USER=root /opt/hadoop/sbin/restart-hdfs-slave.sh
USER=root /opt/hadoop/sbin/restart-yarn-slave.sh

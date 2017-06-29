#!/bin/bash
role=$1
if [ $# -lt 1 ];then
    echo error!
else
    cp -r confd/$role/conf.d /etc/confd/
    cp -r confd/$role/templates /etc/confd/
    cp -r scripts/hadoop/sbin /opt/hadoop/
    cp -r scripts/spark/sbin /opt/spark/
fi

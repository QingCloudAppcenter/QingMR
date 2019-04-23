#!/bin/bash
ret=0
source /etc/profile
/opt/hive/sbin/init-metastore.sh
/opt/hive/bin/hive --service metastore -p 9083  &>/dev/null &
ret=$?
exit $ret
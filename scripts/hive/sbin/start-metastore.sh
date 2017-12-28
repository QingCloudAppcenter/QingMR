#!/bin/bash
ret=0
source /etc/profile
/opt/hive/bin/hive --service metastore -p 9083 &
ret=$?
exit ret
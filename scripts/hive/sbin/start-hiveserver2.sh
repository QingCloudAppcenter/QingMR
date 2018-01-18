#!/bin/bash
ret=0
source /etc/profile
nohup /opt/hive/bin/hive --service hiveserver2 &>/dev/null &
ret=$?
exit ret
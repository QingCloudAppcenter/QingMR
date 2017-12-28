#!/bin/bash
ret=0
source /etc/profile
/opt/hive/bin/hive --service hiveserver2 &
ret=$?
exit ret
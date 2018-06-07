#!/bin/bash
ret=0
if [ ! -d "/data/var" ]; then
    tar xzf /var.tar.gz -C /data/
    rm -rf /var.tar.gz
fi
service mysql start
ret=$?
exit $ret
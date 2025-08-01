#!/bin/sh
   
grep -v -E '127.0.1.1|localhost'  /etc/hosts >> /etc/hosts1
grep -vxFf /etc/hosts.tmp /etc/hosts1  >> /etc/hosts.tmp

if [ -f /etc/hosts.exclude ]; then
    grep -vxFf /etc/hosts.exclude /etc/hosts.tmp > /etc/hosts
    rm /etc/hosts.exclude
else
    cat /etc/hosts.tmp > /etc/hosts
fi

rm /etc/hosts1;

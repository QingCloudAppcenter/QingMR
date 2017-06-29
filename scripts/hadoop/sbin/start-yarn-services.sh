#!/usr/bin/env bash
USER=root /opt/hadoop/sbin/start-yarn.sh
USER=root /opt/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver

#!/usr/bin/env bash
USER=root /opt/hadoop/sbin/stop-yarn.sh
USER=root /opt/hadoop/sbin/mr-jobhistory-daemon.sh stop historyserver

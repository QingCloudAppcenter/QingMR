#!/usr/bin/env bash
USER=root /opt/spark/sbin/stop-all.sh
USER=root /opt/livy/bin/livy-server stop

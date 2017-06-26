#!/usr/bin/env bash
USER=root /opt/spark/sbin/start-all.sh
USER=root /opt/livy/bin/livy-server start

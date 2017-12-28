#!/bin/bash
kill `ps ax | grep HiveMetaStore | grep -v grep | awk '{print $1}'` &>/dev/null
exit 0
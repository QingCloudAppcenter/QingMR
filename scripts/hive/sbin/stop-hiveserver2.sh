#!/bin/bash
kill -9 `ps ax | grep HiveServer2 | grep -v grep | awk '{print $1}'` &>/dev/null
exit 0
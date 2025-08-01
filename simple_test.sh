#!/usr/bin/env bash

echo "=== 简单测试 ==="
echo

# 模拟原始命令
echo "原始命令输出："
ps ax | grep dinky | grep -v grep
echo

echo "获取 PID："
pid=$(ps ax | grep dinky | grep -v grep | awk '{print $1}')
echo "PID: '$pid'"
echo "PID 长度: ${#pid}"
echo

echo "条件测试："
if [ "x$pid" = "x" ]; then
    echo "PID 为空"
else
    echo "PID 不为空: '$pid'"
fi 
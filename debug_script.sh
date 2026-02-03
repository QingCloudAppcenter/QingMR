#!/usr/bin/env bash

echo "=== 调试脚本匹配问题 ==="
echo

echo "1. ps ax 输出（前10行）："
ps ax | head -10
echo

echo "2. 查找包含 'debug' 的进程："
ps ax | grep debug
echo

echo "3. 排除 grep 进程："
ps ax | grep debug | grep -v grep
echo

echo "4. 获取 PID："
pid=$(ps ax | grep debug | grep -v grep | awk '{print $1}')
echo "PID: '$pid'"
echo

echo "5. 检查当前脚本是否被匹配："
echo "当前脚本名称: $0"
echo "当前脚本内容是否包含 'debug':"
grep -q debug "$0" && echo "是" || echo "否"
echo

echo "6. 模拟 dinky 检测："
echo "假设脚本名为 'dinky_test.sh'，内容包含 'dinky'"
echo "那么 ps ax | grep dinky 会匹配到这个脚本进程" 
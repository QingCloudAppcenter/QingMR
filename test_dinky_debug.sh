#!/usr/bin/env bash

echo "=== 测试 dinky 进程检测 ==="
echo

echo "1. 检查是否有 dinky 进程："
ps ax | grep dinky
echo "退出码: $?"
echo

echo "2. 排除 grep 进程："
ps ax | grep dinky | grep -v grep
echo "退出码: $?"
echo

echo "3. 获取 PID："
pid=$(ps ax | grep dinky | grep -v grep | awk '{print $1}')
echo "PID 变量值: '$pid'"
echo "PID 变量长度: ${#pid}"
echo "PID 是否为空: $([ -z "$pid" ] && echo "是" || echo "否")"
echo

echo "4. 测试条件判断："
if [ "x$pid" = "x" ]; then
    echo "条件成立: pid 为空字符串"
else
    echo "条件不成立: pid 不为空，值为: '$pid'"
fi
echo

echo "5. 使用 -n 测试："
if [ -n "$pid" ]; then
    echo "PID 不为空: '$pid'"
else
    echo "PID 为空"
fi
echo

echo "6. 使用 -z 测试："
if [ -z "$pid" ]; then
    echo "PID 为空"
else
    echo "PID 不为空: '$pid'"
fi 
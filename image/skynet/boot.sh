#!/bin/bash

# 启动 ssh
/usr/sbin/sshd

while getopts "d:c" option
do
    echo "${option}:${OPTARG}"
    case $option in
        c|compile)
            compile=true
        ;;
        d|delay)
            delay_ti=${OPTARG}
        ;;
    esac
done

# 编译
if [ $compile ]; then
    echo "compile"
    make linux
fi

# 延迟启动，解决容器启动顺序问题
if [ "$delay_ti" != "" ]; then
    echo "sleep ${delay_ti}"
    sleep ${delay_ti}
fi

# 启动
cd /opt/app
# 执行你的启动脚本
source ./start.sh

/bin/bash
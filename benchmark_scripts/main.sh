#!/bin/bash

echo "start to run testings..."

cd $(dirname $0) || {
	echo "error"
	exit 1
}

if [[ $# -ne 1 ]]; then
   echo "error, Usage: $0 block_dev_name"
   exit 1
fi
dev=$1

echo "##########$(date +%Y%m%d-%T)"
# bash ./superpi.sh
# echo "##########$(date +%Y%m%d-%T)"
# bash ./unix_bench.sh
# echo "##########$(date +%Y%m%d-%T)"
# bash ./fio.sh $dev
# echo "##########$(date +%Y%m%d-%T)"
# stream只适配了x86架构，arm架构无法跑起来
bash ./stream.sh
# echo "##########$(date +%Y%m%d-%T)"
# # mlc 只适配了x86架构，arm架构无法跑起来
# bash ./mlc.sh
echo "##########$(date +%Y%m%d-%T)"

#netperf涉及服务器和客户端，需手动测试
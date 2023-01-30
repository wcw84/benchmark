#!/bin/bash

echo "start to run testings..."

cd $(dirname $0) || {
	echo "error"
	exit 1
}

bash ./superpi.sh
bash ./unix_bench.sh
bash ./fio.sh
bash ./stream.sh
bash ./mlc.sh

#netperf涉及服务器和客户端，需手动测试
#!/bin/bash
# arm架构无法支持

source ./config.sh

echo "############run $0#############"
arch=$(uname -i)
if [[ $arch == 'aarch64' ]]; then
	echo "stream doesn't support $arch, exit"
	exit 1
fi

workDir=$workDirRoot/stream
mkdir -p $workDir
cd $workDir

wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c -O stream.c
sudo yum -y install gcc

# 获取可用 memory
available_memory_size=`free -m | grep Mem | awk '{print ($4)*1024*1024}'`
# 计算最大 array_size
array_size=$((available_memory_size/8/3))
# 编译 stream
gcc -O stream.c -fopenmp -DSTREAM_ARRAY_SIZE=$array_size -DNTIME=30 -mcmodel=large -o stream.o
# 执行测试
./stream.o > stream.log
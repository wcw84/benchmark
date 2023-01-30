#!/bin/bash

echo "############run $0#############"
workDir=/hh-test/steam
mkdir -p $workDir
cd $workDir

wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c -O stream.c
yum -y install gcc

# 获取可用 memory
available_memory_size=`free -m | grep Mem | awk '{print ($4)*1024*1024}'`
# 计算最大 array_size
array_size=$((available_memory_size/8/3))
# 编译 stream
gcc -O stream.c -fopenmp -DSTREAM_ARRAY_SIZE=$array_size -DNTIME=30 -mcmodel=medium -o stream.o
# 执行测试
./stream.o > steam.log
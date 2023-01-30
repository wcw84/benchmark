#!/bin/bash

workDir=/hh-test/unix_bench
mkdir -p $workDir
cd $workDir

pkg=UnixBench-5.1.6

install() {
	cd $workDir
	wget https://github.com/aliyun/byte-unixbench/releases/download/v5.1.6/${pkg}.tar.gz -O ${pkg}.tar.gz
	tar xvf ${pkg}.tar.gz
	cd $pkg/UnixBench
	make
}

run_singlecore_test() {
	echo "run_singlecore_test..."
	cd $workDir/$pkg/UnixBench
	./Run -c 1 >> $workDir/singlecore_test.log
}

run_multicore_test() {
	echo "run_multicore_test..."
	cd $workDir/$pkg/UnixBench
	n=$(cat /proc/cpuinfo | grep process | wc -l)
	./Run -c $n >> $workDir/multicore_test.log
}

# install dependency
yum -y install make automake gcc autoconf gcc-c++ time perl-Time-HiRes
if [[ ! -e $pkg/UnixBench/Run ]];
then
	install
fi

echo "############run $0#############"
run_singlecore_test 
run_multicore_test
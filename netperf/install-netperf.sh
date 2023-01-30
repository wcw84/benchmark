#!/bin/bash

echo "############run $0#############"
workDir=/hh-test/netperf
mkdir -p $workDir
cd $workDir

install() {
	cd $workDir
	wget -c https://codeload.github.com/HewlettPackard/netperf/tar.gz/netperf-2.7.0 -O netperf-2.7.0.tgz
	tar -xzvf netperf-2.7.0.tgz
	yum install gcc sysstat -y
	cd netperf-netperf-2.7.0
	./configure && make && make install
	which netperf
}

install
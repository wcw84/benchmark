#!/bin/bash
source ./config.sh

echo "############run $0#############"
workDir=$workDirRoot/

server_ip=$1
connect_num=64
protocol=$2
size=1
killall netperf
for j in `seq $connect_num`
do
	port=$[16000+j]
	netperf -H ${server_ip} -l 60 -t ${protocol} -p $port -- -m 1400 -D > $workDir/netperfstream.log 2>&1 &
done
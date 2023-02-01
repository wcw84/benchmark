#!/bin/bash
source ./config.sh

echo "############run $0#############"
workDir=$workDirRoot/

connect_num=64
size=1
killall netserver
for j in `seq $connect_num`
do
	port=$[16000+j]
	netserver -p $port > > $workDir/netserverstream.log 2>&1 &
done
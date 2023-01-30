#!/bin/bash
connect_num=64
size=1
killall netserver
for j in `seq $connect_num`
do
	port=$[16000+j]
	netserver -p $port > netserverstream.log 2>&1 &
done
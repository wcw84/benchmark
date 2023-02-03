#!/bin/bash
source ./config.sh

# f=./ip-list.txt
cer=../config/from-jump.cer

# server_ip=$(grep server $f | awk '{print $2}')
server_ip=$server
start_clients() {
	client_ip_list=$clients
	client_ip_array=${client_ip_list//,/ }
	for ip in $client_ip_array
	do
		echo "ssh -o StrictHostKeyChecking=no -i $cer root@$ip 'bash -s' < client-ab.sh $server_ip $totalNum $concurrency>> results/$ip.log"
		ssh -o StrictHostKeyChecking=no -i $cer root@$ip 'bash -s' < client-ab.sh $server_ip $totalNum $concurrency>> results/$ip-1.log 2>&1 &
	done
}
start_clients

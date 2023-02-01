#!/bin/bash

f=./ip-list.txt
cer=../config/from-jump.cer

server_ip=$(grep server $f | awk '{print $2}')
start_clients() {
	client_ip_list=$(grep client $f | awk '{print $2}')
	client_ip_array=${client_ip_list//,/ }
	for ip in $client_ip_array
	do
		echo "ssh -o StrictHostKeyChecking=no -i $cer root@$ip 'bash -s' < client-ab.sh $server_ip >> results/$ip.log"
		ssh -o StrictHostKeyChecking=no -i $cer root@$ip 'bash -s' < client-ab.sh $server_ip >> results/$ip-1.log 2>&1 &
		# ssh -o StrictHostKeyChecking=no -i $cer root@$ip 'bash -s' < client-ab.sh $server_ip >> results/$ip-2.log 2>&1 &
	done
}
start_clients

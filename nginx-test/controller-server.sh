#!/bin/bash

f=./ip-list.txt
cer=../config/from-jump.cer

server_ip=$(grep server $f | awk '{print $2}')
# echo $server_ip;
start_server() {
	ip=$server_ip
	echo "##############start_server $ip..."

	echo rsync -avz --progress -e "ssh -o StrictHostKeyChecking=no -i $cer" nginx-test.conf  root@$ip:/tmp/nginx-test.conf
	rsync -avz --progress -e "ssh -o StrictHostKeyChecking=no -i $cer" nginx-test.conf  root@$ip:/tmp/nginx-test.conf
	rsync -avz --progress -e "ssh -o StrictHostKeyChecking=no -i $cer" sysctl.conf  root@$ip:/tmp/sysctl.conf

	echo "ssh -o StrictHostKeyChecking=no -i $cer root@$ip < server-nginx.sh"
	ssh -o StrictHostKeyChecking=no -i $cer root@$ip < server-nginx.sh
}

start_server



# start_clients() {
# 	client_ip_list=$(grep client $f | awk '{print $2}')
# 	client_ip_array=${client_ip_list//,/ }
# 	for ip in $client_ip_array
# 	do
# 		# echo $ip
# 		echo "ssh -o StrictHostKeyChecking=no -i $cer root@$ip 'bash -s' < client-ab.sh $server_ip"
# 		ssh -o StrictHostKeyChecking=no -i $cer root@$ip 'bash -s' < client-ab.sh $server_ip  > $ip.log 2>&1 &
# # nohup bash $script $ip $user $cer $dev>$ip.log 2>&1 &
# 	done
# }
# start_clients

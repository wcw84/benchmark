#!/bin/bash
# source ./config.sh

echo "############run $0#############"
# workDir=$workDirRoot/nginx
# mkdir -p $workDir
# cd $workDir
server_ip=$1
totalNum=$2
concurrency=$3

install_ab() {
	which ab >/dev/null
	if [[ $? -ne 0 ]];
	then
		# install ab
		echo "installing ab..."
		sudo yum -y install httpd-tools
		which ab
	fi
}

run_client() {
	url=http://${server_ip}/
	# totalNum=200000
	# concurrency=10000

	echo "ab -n $totalNum -c $concurrency -s 30 $url" 
	ab -n $totalNum -c $concurrency -s 30 $url
}


install_ab
run_client


#!/bin/bash

if [[ $# -ne 4 ]]; then
   echo "error"
   exit 1
fi

ip=$1
user=$2
cer=$3
dev=$4
scriptDir=benchmark_scripts

# upload file
echo "##############upload script to $ip..."
echo rsync -avz --progress -e "ssh -o StrictHostKeyChecking=no -i $cer" ../benchmark_scripts $user@$ip:~/
rsync -avz --progress -e "ssh -o StrictHostKeyChecking=no -i $cer" ../benchmark_scripts $user@$ip:~/

# install and run
echo "##############unning test..."
echo ssh -i $cer $user@$ip "cd benchmark_scripts; bash ./main.sh $dev;"
ssh -i $cer $user@$ip "cd benchmark_scripts; bash ./main.sh $dev;"

# copy result
echo "##############copy result"
# scp -i $cer -r $user@$ip:/var/tmp/hh-test result/$ip
echo rsync -avz --progress --include "*.log" -e "ssh -i $cer" $user@$ip:/var/tmp/hh-test ../results/$ip
rsync -avz --progress --include "*.log" -e "ssh -i $cer" $user@$ip:/var/tmp/hh-test ../results/$ip

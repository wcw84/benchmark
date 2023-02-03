#!/bin/bash

f=../config/ec2-list.txt
script=./run-one-ip.sh
cer=../config/from-jump.cer
# for line in $(cat $f)
# do
#  echo $line
# done

while read -r line
do
   # echo $line
   c=${line:0:1}
   if [[ $c == "#" ]]; then
      echo "comment line: $line, skip"
      continue;
   fi
   ip=$(echo $line | awk '{print $1}')
   user=$(echo $line | awk '{print $2}')
   dev=$(echo $line | awk '{print $3}')
   echo "##########Testing ip=$ip, user=$user, dev=$dev..."
   echo "nohup bash $script $ip $user $cer $dev>$ip.log 2>&1 &"
   nohup bash $script $ip $user $cer $dev>$ip.log 2>&1 &
done < $f


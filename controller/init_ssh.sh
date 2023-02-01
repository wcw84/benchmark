#!/bin/bash

f=../config/ec2-list.txt
cer=../config/from-jump.cer
# for line in $(cat $f)
# do
#  echo $line
# done

while read -r line
do
   echo $line
   ip=$(echo $line | awk '{print $1}')
   user=$(echo $line | awk '{print $2}')

   echo "ssh -o StrictHostKeyChecking=no -i $cer ec2-user@${ip}" "sudo cp -a ~/.ssh/authorized_keys /root/.ssh/authorized_keys; sudo chown root:root /root/.ssh/authorized_keys"
   ssh -o StrictHostKeyChecking=no -i $cer ec2-user@${ip} "sudo cp -a ~/.ssh/authorized_keys /root/.ssh/authorized_keys; sudo chown root:root /root/.ssh/authorized_keys"
done < $f



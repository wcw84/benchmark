#!/bin/bash
# arm架构无法支持

source ./config.sh

echo "############run $0#############"
workDir=$workDirRoot/mlc
mkdir -p $workDir
cd $workDir

wget wget https://downloadmirror.intel.com/763324/mlc_v3.10.tgz -O mlc_v3.10.tgz
tar xvf mlc_v3.10.tgz

./Linux/mlc --idle_latency -e -r -l128 -D8192 >mlc.log

#!/bin/bash

echo "############run $0#############"
workDir=/hh-test/mlc
mkdir -p $workDir
cd $workDir

wget wget https://downloadmirror.intel.com/763324/mlc_v3.10.tgz -O mlc_v3.10.tgz
tar xvf mlc_v3.10.tgz

./Linux/mlc --idle_latency -e -r -l128 -D8192 >mlc.log

#!/bin/bash
source ./config.sh

echo "############run $0#############"
workDir=$workDirRoot/superpi
mkdir -p $workDir
cd $workDir
s=5000

run_singlecore_test() {	
	echo "run_singlecore_test..."
	cd $workDir
	(time echo "scale=${s}; 4*a(1)" | bc -l -q &>/dev/null) |& grep real >> $workDir/singlecore_test.log
	#time echo "scale=5000; 4*a(1)" | bc -l -q &>1
}

run_multicore_test() {
	echo "run_multicore_test..."
	cd $workDir
	cpu_seqs=`cat /proc/cpuinfo | grep proce | sed -e "s/.* //g" | tr -s '\n' ' '`
	for cpu_seq in $cpu_seqs;do
		# (time echo "scale=1000; 4*a(1)" | bc -l -q &>/dev/null) |& grep real > out.txt &
		echo "echo scale=${s}; 4*a(1) | taskset -c ${cpu_seq} bc -l -q &>/dev/null"
		(time echo "scale=${s}; 4*a(1)" | taskset -c $cpu_seq bc -l -q &>/dev/null) |& grep real >> $workDir/multicore_test.log & 
	done

	process_num=$(cat /proc/cpuinfo | grep process | wc -l)
	for((i=0; i<$process_num; i++)); do
		 j=$(echo "$i+1" | bc -l)  
		 wait %$j 
		 echo $? 
	done
	#for cpu_seq in $cpu_seqs;do time echo "scale=5000; 4*a(1)" | taskset -c $cpu_seq bc -l -q &>1 & done
}

run_singlecore_test 
run_multicore_test
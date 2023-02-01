#!/bin/bash
source ./config.sh

if [[ $# -ne 1 ]]; then
   echo "error, Usage: $0 block_dev_name"
   exit 1
fi

echo "############run $0#############"
workDir=$workDirRoot/fio
mkdir -p $workDir
cd $workDir
dev=$1

install() {
	cd $workDir
	wget https://codeload.github.com/axboe/fio/tar.gz/fio-3.8 -O fio-3.8.tgz
	tar xvf fio-3.8.tgz
	cd fio-fio-3.8/
	sudo yum install libaio libaio-devel gcc-c++ -y
	./configure && make && sudo make install
	which fio
}

which fio >/dev/null
if [[ $? -ne 0 ]];
then
	install
fi

test1() {
	#dev=/dev/nvme1n1  不同os，这里名称不同
	testSeconds=300
	echo "Testing write bandwidth..."
	echo fio -direct=1 -iodepth=64 -rw=write -ioengine=libaio -bs=1024k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Write_BW_Testing
	fio -direct=1 -iodepth=64 -rw=write -ioengine=libaio -bs=1024k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Write_BW_Testing

	echo "Testing read bandwidth..."
	echo fio -direct=1 -iodepth=64 -rw=read -ioengine=libaio -bs=1024k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Read_BW_Testing
	fio -direct=1 -iodepth=64 -rw=read -ioengine=libaio -bs=1024k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Read_BW_Testing

	echo "Testing write Random..."
	echo fio -direct=1 -iodepth=128 -rw=randwrite -ioengine=libaio -bs=4k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Rand_Write_Testing
	fio -direct=1 -iodepth=128 -rw=randwrite -ioengine=libaio -bs=4k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Rand_Write_Testing

	echo "Testing read Random..."
	echo fio -direct=1 -iodepth=128 -rw=randread -ioengine=libaio -bs=4k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Rand_Read_Testing
	fio -direct=1 -iodepth=128 -rw=randread -ioengine=libaio -bs=4k -size=10G -numjobs=1 -runtime=$testSeconds -group_reporting -filename=$dev -name=Rand_Read_Testing
}

test1 > $workDir/fio.log 2>&1
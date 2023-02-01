#!/bin/bash
# source ./config.sh

echo "############run $0#############"
# workDir=$workDirRoot/nginx
# mkdir -p $workDir
# cd $workDir

install() {	
	echo "installing nginx"
	cd /tmp
	yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel
	wget http://nginx.org/download/nginx-1.22.1.tar.gz
	tar xvf nginx-1.22.1.tar.gz
	cd nginx-1.22.1
	./configure && make && sudo make install

}

if [[ ! -e /usr/local/nginx/sbin/nginx ]];
then
	install
fi

run_server() {
	echo "killall -9 nginx"
	killall -9 nginx

	cp -a /tmp/sysctl.conf /etc/sysctl.conf
	sysctl -p

	cp -a /tmp/nginx-test.conf /usr/local/nginx/conf/
	nginx_bin=/usr/local/nginx/sbin/nginx
	conf=/usr/local/nginx/conf/nginx-test.conf

	echo $nginx_bin -c $conf
	$nginx_bin -c $conf
}

run_server



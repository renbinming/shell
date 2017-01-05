#!/bin/sh
DIR=/data0/mysql
MAX_PORT=3306

mode=$1

case "$mode" in

	'start')
	#start slaves
	
	for  (( i=3306; i<=$MAX_PORT; i++ ))
	do
		mysql -S $DIR/$i/mysql.sock  -e "start slave;"
	done	
	;;

	'stop')

	#stop slaves
	
	for  (( i=3306; i<=$MAX_PORT; i++ ))
	do
		mysql -S $DIR/$i/mysql.sock  -e "stop slave;"
	done
	;;
	
	*)
		echo "wrong param,please input {start|stop}"
	;;

esac
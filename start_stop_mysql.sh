#!/bin/sh
DIR=/data0/mysql
MAX_PORT=3306

mode=$1

case "$mode" in

	'start')
	#Start mysql  process
	for  (( i=3306; i<=$MAX_PORT; i++ ))
	do
		 $DIR/$i/mysqld start
	done
	;;
	
	'stop')

	#Stop mysql  process
	
	for  (( i=3306; i<=$MAX_PORT; i++ ))
	do
		 $DIR/$i/mysqld stop
	done
	;;
	
	
	*)
		echo "Wrong param, please input {start|stop}"
	;;
esac

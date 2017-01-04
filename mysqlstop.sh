DIR=/data0/mysql
MAX_PORT=3306
for  (( i=3306; i<=$MAX_PORT; i++ ))
do
	 $DIR/$i/mysqld stop
done

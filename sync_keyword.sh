#!/bin/bash
set -u
set -e 

BIN_DIR=/usr/local/webserver/mysql/bin
SOCK_DIR=/data0/mysql/3306/mysql.sock
S_TABLE=v9_wx_keyword
D_TABLE1=jk_wx_keyword
D_TABLE2=ye_wx_keyword
DB1=
DB2=
LOGFILE=/data0/logs/cron/sync_keyword.log
IP=
TIME=$(date +%F%T)

function backup(){
    if [ ! -e `dirname $LOGFILE` ]
        then
            mkdir -p `dirname $LOGFILE`
    fi
    ssh -i /data0/scripts/id_rsa  -o 'StrictHostKeyChecking no' root@$IP "$BIN_DIR/mysqldump -S $SOCK_DIR $DB1 $S_TABLE > /tmp/$S_TABLE.sql"
    echo "$TIME backup success!" >> $LOGFILE
}

function get_table(){
    scp -i /data0/scripts/id_rsa root@$IP:/tmp/$S_TABLE.sql /tmp
}

function replace(){
    cp /tmp/$S_TABLE.sql /tmp/$D_TABLE1.sql
    cp /tmp/$S_TABLE.sql /tmp/$D_TABLE2.sql
    sed -i "s#${S_TABLE}#${D_TABLE1}#g" /tmp/$D_TABLE1.sql
    sed -i "s#${S_TABLE}#${D_TABLE2}#g" /tmp/$D_TABLE2.sql
}

function sync(){
    $BIN_DIR/mysql -S $SOCK_DIR $DB2 < /tmp/$D_TABLE1.sql
    echo "$TIME sync success!" >> $LOGFILE
}

backup
get_table
replace
#sync

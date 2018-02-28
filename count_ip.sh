#!/bin/bash
DIR=/data3
SUB_DOMAIN=$1
DOMAIN=$2

function unarchive(){
    RES=$(ls -l $DIR|grep gz|grep $DOMAIN|awk '{print $9}')
    if [ -n "$RES" ]; then
        for zipfile in $RES
        do
            gunzip $zipfile
            echo "解压文件中..."
        done
    fi
}

function count(){
    ls -l $DIR|awk '{print $9}'|grep $DOMAIN|grep cn.log > $DIR/file.txt
    COMMAND=$(cat $DIR/file.txt)
    for i in $COMMAND
    do
        DATE=$(ls -l $i|awk '{print $9}'|awk -F \- '{print $1"-"$2"-"$3}')
        RESULT=$(grep $SUB_DOMAIN $i|grep -v favicon|awk '{print $1}'|sort|uniq -c|wc -l)
        echo "$DATE IP count: $RESULT"
#        RESULT2=$(grep $SUB_DOMAIN $i|grep -v favicon|awk '{print $9}'|sort|uniq -c)
#        echo "$RESULT2"
    done
}

unarchive
count

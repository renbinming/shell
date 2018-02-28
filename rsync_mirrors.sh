#!/bin/bash
#  
#  备注：用于同步镜像并打印下载链接

set -e
set -u

IP1=xxx.xxx.xxx.xxx
IP2=xxx.xxx.xxx.xxx
MIRROR_DIR=/data0/mirrors
DIR_LIST=$(find ${MIRROR_DIR} -maxdepth 2 -mindepth 2 -mtime -3 -type d)
URL_LIST=$(find ${MIRROR_DIR} -mtime -3 -type f)
URL_PRE="http://xxx.xxx.com"

#同步镜像
function sync_mirror(){
    for DIR in $DIR_LIST
    do
        BASEDIR=$(echo $DIR|awk -F "/" '{print "/"$2"/"$3"/"$4"/"$5"/"$6}')
        if [ -n $BASEDIR ];
        then
            echo "正在传输----$IP1----"
            rsync -avP $DIR $IP1:$BASEDIR
            echo "正在传输----$IP2----"
            rsync -avP $DIR $IP2:$BASEDIR
        fi
    done
}

#打印下载链接
function get_downloadurl(){
    for URL in $URL_LIST
    do
        URL_PATH=$(echo $URL|awk -F "/" '{print "/"$5"/"$6"/"$7"/"$8}')
        echo ${URL_PRE}${URL_PATH}
    done
}

sync_mirror
get_downloadurl

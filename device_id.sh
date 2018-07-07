#!/bin/bash
function echored(){
        echo -e "\033[31m$1\033[0m"
}
function echousage(){
    echored "usage:"
    echored "      device_id.sh start-value id-count [file]"
    exit 0
}
echored "wait-for-device"
adb wait-for-device
brand=`adb shell getprop ro.product.brand`
device=`adb shell getprop ro.product.device`
target=~/BRAND_ID.txt
if [ $# -eq 0 ];then
    echousage
elif [ $1 == 'help' ];then
    echousage
elif [ $# -eq 2 ];then
    startval=$1
    count=$2
elif [ $# -eq 3 ];then
    startval=$1
    count=$2
    target=$3
fi
echo -n "" >$target
for (( i=0; i<$count; i=i+1))
do
    currentid=`printf "%08d\n" $[ ${startval}+${i}  ]`
    echo "${brand}_${device}_${currentid}">>$target
done


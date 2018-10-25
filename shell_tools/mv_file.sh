#!/bin/bash

#set -x
#set -e

pids=`ls ../pcap/*pcap`
echo $pids
OLD_IFS="$IFS" 
IFS=" "
arr=($pids)
IFS="$OLD_IFS" 
#echo $arr
#i=0
`chmod +x ../pcap/*pcap`
for pid in ${arr[@]}
do
    echo "$pid"
    `mv $pid /data/serverids_pcaps/`
    read input
    if [ "$input" = "0" ];then
        echo "write $pid to ioc_warn.txt"
        echo "$pid" >> _warn.txt
	echo -e "\n" >> warn.txt
    fi
done
#echo $pids

#OLD_IFS="$IFS" 
#IFS=" " 
#arr=($a) 
#IFS="$OLD_IFS" 
#for s in ${arr[@]} 
#do 
#    echo "$s" 
#    `kill -9 "$s"`
#done


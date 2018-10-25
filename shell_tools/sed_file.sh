#!/bin/bash

SRC_INFO=$1
SRC_INFO=$2
FILE_NAME=$3

if [ $# -lt 3 ]; then
	echo "need three params
		1: src_info
		2: dst_info
		3: file_name"
	exit
fi 
echo $1 $2 $3

#sed -i '/word/{s/word/china/;p}' 
sed -i 's/$SRC_INFO/$DST_INFO/g' $FILE_NAME

#!/bin/bash

root_dir=`pwd`
cmd="pcapReplay -i eth1 -f"
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
			if [ "${dir_or_file##*.}" = "pcap" ]; then
				#while true;do
				read -p "Enter input:" num
				echo $num
				if [[ $num == 'quit' ]]; then
					exit 0
				elif [[ $num == 'c' ]]; then
            		echo "skip-----$dir_or_file"
				else
            		echo $dir_or_file
					echo `$cmd $dir_or_file`
				fi
				#done
			fi
        fi  
    done
}

getdir $root_dir

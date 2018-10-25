if [ $# -lt 1 ]; then
	echo $#
	exit 1
fi

tcpdump -i eth0 -w php_$1_upload.pcap

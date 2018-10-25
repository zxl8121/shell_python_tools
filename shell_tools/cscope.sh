#!/bin/bash
DIR=..
SRC_FILE=cscope.files
TMP_FILE=cscope.files1
if [ $# -lt  1 ]; then
	echo "need 1 input params: \
			1: product $SRC_FILE\
			2: cscope -bkq -i $SRC_FILE\
			3: ctages -R\
			other: 1->2->3" 
	exit 1
fi
function add_absolute_path()
{
	cur_dir=`pwd`
	rm -rf $SRC_FILE1
	cat $SRC_FILE | while read line; do
		echo $cur_dir"/"$line >> $TMP_FILE;
	done
	mv $TMP_FILE $SRC_FILE
}
function product_cscope_files()
{
	find $DIR -name "*.h" -o -name "*.c" -o -name "*.cc" -name "*.cpp" > $SRC_FILE
}
function product_cscope_out()
{
	cscope -bkq -i $SRC_FILE
}
function product_ctages()
{
	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $DIR
}
function product_all()
{
	product_cscope_files
	product_cscope_out
	product_ctages
}
if [ $1 -eq 1 ]; then
	echo "product $SRC_FILE"
	product_cscope_files
	add_absolute_path
	#python2.7 cscope.py
elif [ $1 -eq 2 ]; then
	echo "cscope -bkq -i $SRC_FILE"
	product_cscope_out
elif [ $1 -eq 3 ]; then
	echo "ctages -R"
	product_ctages
else
	echo "all process"
	product_all
fi

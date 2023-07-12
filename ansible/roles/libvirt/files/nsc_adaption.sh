#!/bin/bash

avx_flag=$(lscpu | grep 'avx2')
sse_flag=$(lscpu | grep 'sse4_2')
flag=1
if [ "$avx_flag" == "" ] || [ "$sse_flag" == "" ]
then
	echo "0"
else
	echo "1"
fi

#!/bin/bash 

# Configure by yourself
date=$(date "+%Y%m%d%H%M%S")
outputfile="cagent-"${date}".txt"
# 10m=10*60s
howlongtime=60

# Get pid
#pid=`ps -ely | grep 'cagent' | awk ' $4 == "1" {print $3}'`
echo "date,VmSize(KB),CPU%"  >> $outputfile
while [ 1 ]; do
	pid=`ps -ely | grep 'cagent' | awk ' $4 == "1" {print $3}'`
	echo -n "`date +"%Y-%m-%d %H:%M:%S"`, " >> $outputfile
	#get VMsize
	mem=`cat /proc/${pid}/status | grep VmSize`
	mem2=`echo  $mem|grep -o '[0-9]\+'` 
    echo -n "$mem2," >> $outputfile
	#get the pid CPU Usage
	# cpu=`top -n 1 -p $pid|tail -2|head -1|awk '{ssd=NF-4} {print $ssd}'`
         cpu=`top -n 1 -p $pid|grep $pid|awk '{print $10}'`
   	 echo "$cpu," >> $outputfile 
	sleep $howlongtime
done

exit 0



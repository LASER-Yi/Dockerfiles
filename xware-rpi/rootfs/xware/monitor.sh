#!/usr/bin/env bash

# this sh is a copy from MrLYC/xware-kodexplorer

while :
do
	sleep 60 & pid=$!
	waitd pid=
    ps -fe | grep ETMDaemon | grep -v grep
        if [ $? -ne 0 ]
        then
            ./portal
        fi
done
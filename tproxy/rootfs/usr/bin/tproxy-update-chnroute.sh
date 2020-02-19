#! /bin/sh
#
# Update CHNROUTE

echo "Updating CHNROUTE..." 

curl -sSL https://raw.githubusercontent.com/PaPerseller/chn-iplist/master/chnroute.txt -o /config/chnroute.txt
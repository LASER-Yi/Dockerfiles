#! /bin/sh
#
# tproxy-import
# This shell is use for import chnip

echo "Import chnip rules..."
tempfile=$(mktemp)

ipset -N chnroute4 hash:net
for i in `cat /config/chnroute4.txt`; do echo ipset -A chnroute4 $i >> $tempfile; done
chmod +x $tempfile

$tempfile

rm -f $tempfile

tempfile=$(mktemp)

ipset -N chnroute6 hash:net family inet6
for i in `cat /config/chnroute6.txt`; do echo ipset -A chnroute6 $i >> $tempfile; done
chmod +x $tempfile

$tempfile

rm -f $tempfile


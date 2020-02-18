#! /bin/sh
#
# tproxy-import
# This shell is use for import chnip

echo "Import chnip rules..."
tempfile=$(mktemp)

ipset -N chnip hash:net
for i in `cat /config/chnroute.txt`; do echo ipset -A chnip $i >> $tempfile; done
chmod +x $tempfile

$tempfile

rm -f $tempfile


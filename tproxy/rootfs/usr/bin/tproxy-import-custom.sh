#! /bin/sh
#
# tproxy-import
# This shell is use for import chnip

echo "Importing custom rules..."
tempfile=$(mktemp)

ipset -N custom_direct hash:net
for i in `cat /config/custom.txt`; do echo ipset -A custom_direct $i >> $tempfile; done
chmod +x $tempfile

$tempfile

rm -f $tempfile

#! /bin/sh
#
# tproxy-import
# This shell is use for import chnip

echo "Importing custom rules..."

# Add custom direct rules
tempfile=$(mktemp)

ipset -N custom_direct hash:net
for i in `cat /config/custom_direct.txt`; do echo ipset -A custom_direct $i >> $tempfile; done
chmod +x $tempfile

$tempfile

rm -f $tempfile

# Add custom proxy rules
tempfile=$(mktemp)

ipset -N custom_proxy hash:net
for i in `cat /config/custom_proxy.txt`; do echo ipset -A custom_proxy $i >> $tempfile; done
chmod +x $tempfile

$tempfile

rm -f $tempfile

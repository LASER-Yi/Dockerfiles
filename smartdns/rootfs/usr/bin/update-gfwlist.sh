#! /bin/sh
#
# Update GFWList

INPUT_FILE=$(mktemp)
OUTPUT_FILE="/config/smartdns.d/gfwlist.conf"

PROXYDNS_NAME="proxydns"

if [ "$1" != "" ]; then
	PROXYDNS_NAME="$1"
fi

curl -o $INPUT_FILE -sSL https://cokebar.github.io/gfwlist2dnsmasq/gfwlist_domain.txt
if [ $? -eq 0 ]
then
	echo "Download successful, updating..."
    mkdir -p /config/smartdns.d/
	cat /dev/null > $OUTPUT_FILE

	cat $INPUT_FILE | while read line
	do
		echo "nameserver /$line/$PROXYDNS_NAME" >> $OUTPUT_FILE
	done
fi

rm $INPUT_FILE

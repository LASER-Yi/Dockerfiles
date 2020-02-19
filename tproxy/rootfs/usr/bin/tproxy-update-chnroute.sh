#! /bin/sh
#
# Update CHNROUTE

echo "Updating CHNROUTE..." 

curl -sSL 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' -o /tmp/chnip
cat /tmp/chnip | grep ipv4 | grep CN | awk -F\| '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' > /config/chnroute4.txt
cat /tmp/chnip | grep ipv6 | grep CN | awk -F\| '{printf("%s/%d\n", $4, $5)}' > /config/chnroute6.txt
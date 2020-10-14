#! /bin/sh
#
# Update CHNROUTE

echo "Updating CHNROUTE..." 

TEMP_FILE=$(mktemp)

curl -o $TEMP_FILE -sSL 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest'

if [ $? -eq 0 ]
then
    cat $TEMP_FILE | grep ipv4 | grep CN | awk -F\| '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' > /config/chnroute4.txt
    cat $TEMP_FILE | grep ipv6 | grep CN | awk -F\| '{printf("%s/%d\n", $4, $5)}' > /config/chnroute6.txt
    rm -rf $TEMP_FILE

    echo "Update successful..."
else
    echo "Cannot fetch APNIC list, update failed..."
fi
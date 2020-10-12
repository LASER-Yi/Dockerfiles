#! /bin/sh
#
# Stop tproxy service

echo "Removing TProxy rules..."

tproxy-clear-iptables.sh

if [ $CHNROUTE_MODE -eq 1 ]
then
    tproxy-delete-ipset.sh
fi

echo "Done"

exit 0

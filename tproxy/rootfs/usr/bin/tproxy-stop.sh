#! /bin/sh
#
# Stop tproxy service

echo "Removing TProxy rules..."

tproxy-clear-iptables.sh

if [ $ENABLE_MINI_MODE -eq 0 ]
then
    tproxy-delete-ipset.sh
fi

echo "Done"

exit 0

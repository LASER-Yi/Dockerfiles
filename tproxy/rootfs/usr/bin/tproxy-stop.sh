#! /bin/sh
#
# Stop tproxy service

echo "Removing TProxy rules..."

tproxy-clear-iptables.sh
tproxy-delete-ipset.sh

echo "Done"

exit 0

#! /bin/sh
#
# Start tproxy 

echo "Adding TProxy rules..."

tproxy-import-chnip.sh
tproxy-import-custom.sh
tproxy-create-iptables.sh

echo "Done"

exit 0

#! /bin/sh
#
# Start tproxy 

echo "Adding TProxy rules..."
echo "TProxy is setting up with mini mode enabled. All connection will redir to $REDIR_PORT."

tproxy-create-iptables.sh

echo "Done"

exit 0

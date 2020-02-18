#! /bin/sh
#
# Delete all ipset rules

echo "Removing all ip rules..."
ipset destroy chnip
ipset destroy custom_direct

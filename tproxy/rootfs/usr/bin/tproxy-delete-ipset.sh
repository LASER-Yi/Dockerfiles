#! /bin/sh
#
# Delete all ipset rules

echo "Removing all ipset tables..."
ipset destroy chnip
ipset destroy custom_direct
ipset destroy custom_proxy

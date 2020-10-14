#! /bin/sh
#
# Delete all ipset rules

echo "Removing all ipset tables..."

ipset destroy chnroute4
ipset destroy chnroute6

ipset destroy custom_direct
ipset destroy custom_proxy

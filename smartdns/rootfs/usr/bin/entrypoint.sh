#! /bin/sh
#
#

# copy smartdns.conf if no exist
[[ ! -f /config/smartdns.conf ]] && cp -r /backup/smartdns.conf /config

exec smartdns -f -x -c /config/smartdns.conf
#! /bin/sh
#
# entrypoint.sh

# copy filter file if no exist
[[ ! -f /config/chnroute.txt ]] && cp -r /backup/* /config

# start dnsmasq service
dnsmasq --cache-size=25000 \
--conf-file=/dev/null \
--conf-dir=/config/dnsmasq.d/ \
--log-facility=/dev/stdout \
--no-resolv \
--server=127.0.0.1#2053 \
--user=root

# start chinadns service
chinadns -p 2053 -c /config/chnroute.txt -v
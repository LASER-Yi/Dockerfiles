#! /bin/sh
#
# entrypoint.sh

# create a daemon for tproxy

trap "tproxy-stop.sh" EXIT

# exit when fail
set +eu

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

# copy tproxy setup file if no exist
[[ ! -f /config/custom-tcp-rule.sh ]] && cp -r /tproxy-backup/* /config

# setup
chmod 755 /config/custom-*

# setting up tproxy iptables
tproxy-start.sh

# start chinadns service as daemon
chinadns -p 2053 -c /config/chnroute.txt -v &

while true; do
    sleep 120s
done

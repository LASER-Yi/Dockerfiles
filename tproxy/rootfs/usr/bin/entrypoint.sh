#! /bin/sh
#
# entrypoint.sh

# create a daemon for tproxy

dnsmasq_pid=0
chinadns_pid=0

trap "sigterm_handler" TERM

sigterm_handler() {
echo "exiting..."

tproxy-stop.sh

if [ $dnsmasq_pid -ne 0 ]; then
  kill -TERM "$dnsmasq_pid"
  wait "$dnsmasq_pid"
fi

if [ $chinadns_pid -ne 0 ]; then
  kill -TERM "$chinadns_pid"
  wait "$chinadns_pid"
fi

exit 143;
}

# exit when fail
set -eu

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

# start chinadns service as daemon
chinadns -p 2053 -c /config/chnroute.txt -v &

# dnsmasq will folk
dnsmasq_pid=$(pidof dnsmasq | sed "s|^\([0-9]*\)\(.*\)|\1|")
chinadns_pid=$(pidof chinadns)

# copy tproxy setup file if no exist
[[ ! -f /config/custom-tcp-rule.sh ]] && cp -r /tproxy-backup/* /config
# setup
chmod 755 /config/custom-*

# setting up tproxy iptables
tproxy-start.sh

wait
set +eu
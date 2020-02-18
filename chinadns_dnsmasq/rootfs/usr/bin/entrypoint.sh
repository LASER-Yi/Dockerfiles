#! /bin/sh
#
# entrypoint.sh

# create a daemon for tproxy

dnsmasq_pid=0
chinadns_pid=0
dns2tcp_pid=0

trap "sigterm_handler" TERM

sigterm_handler() {
echo "exiting..."

if [ $dnsmasq_pid -ne 0 ]; then
  kill -TERM "$dnsmasq_pid"
  wait "$dnsmasq_pid"
fi

if [ $chinadns_pid -ne 0 ]; then
  kill -TERM "$chinadns_pid"
  wait "$chinadns_pid"
fi

if [ $dns2tcp_pid -ne 0 ]; then
  kill -TERM "$dns2tcp_pid"
  wait "$dns2tcp_pid"
fi

exit 143;
}

# exit when fail
set -eu

# copy filter file if no exist
[[ ! -f /config/chnroute.txt ]] && cp -r /backup/* /config

# start dns2tcp service as daemon
dns2tcp -L 127.0.0.1#60024 -R ${TRUST_DNS}#53 &

# start chinadns service as daemon
chinadns -p 60023 \
 -c /config/chnroute.txt \
 -s ${CHINA_DNS},127.0.0.1:60024 \
 -v &

# start dnsmasq service
dnsmasq --cache-size=25000 \
--conf-file=/dev/null \
--conf-dir=/config/dnsmasq.d/ \
--log-facility=/dev/stdout \
--no-resolv \
--server=127.0.0.1#60023 \
--user=root 

# dnsmasq will folk
dnsmasq_pid=$(pidof dnsmasq | sed "s|^\([0-9]*\)\(.*\)|\1|")
chinadns_pid=$(pidof chinadns)
dns2tcp_pid=$(pidof dns2tcp)

wait
set +eu
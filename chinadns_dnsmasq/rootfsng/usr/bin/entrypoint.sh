#! /bin/sh
#
# entrypoint.sh

# create a daemon for tproxy

dnsmasq_pid=0
chinadnsng_pid=0
dns2tcp_pid=0

trap "sigterm_handler" TERM

sigterm_handler() {
echo "exiting..."

if [ $dnsmasq_pid -ne 0 ]; then
  kill -TERM "$dnsmasq_pid"
  wait "$dnsmasq_pid"
fi

if [ $chinadnsng_pid -ne 0 ]; then
  kill -TERM "$chinadnsng_pid"
  wait "$chinadnsng_pid"
fi

if [ $dns2tcp_pid -ne 0 ]; then
  kill -TERM "$dns2tcp_pid"
  wait "$dns2tcp_pid"
fi

exit 143;
}

# exit when fail
set -eu

# copy dnsmasq.conf if no exist
[[ ! -f /config/dnsmasq.conf ]] && cp -r /etc/dnsmasq.conf /config
[[ ! -f /config/dnsmasq.d ]] && mkdir -p /config/dnsmasq.d/ && cp -r /backup/dnsmasq.d/* /config/dnsmasq.d/

# start dns2tcp service as daemon
dns2tcp -L 127.0.0.1#60024 -R ${TRUST_DNS}#53 &

# start chinadns service as daemon
chinadns-ng -l 60023 \
 -c ${CHINA_DNS} \
 -t 127.0.0.1#60024 \
 --ipset-name4 ${IPSET_NAME} \
 --ipset-name6 ${IPSET_NAME6} \
 ${CHINADNS_OPTION} &

# start dnsmasq service
dnsmasq --cache-size=25000 \
--conf-file=/config/dnsmasq.conf \
--conf-dir=/config/dnsmasq.d/ \
--log-facility=/dev/stdout \
--no-resolv \
--server=127.0.0.1#60023 \
--user=root 

# dnsmasq will folk
dnsmasq_pid=$(pidof dnsmasq | sed "s|^\([0-9]*\)\(.*\)|\1|")
chinadnsng_pid=$(pidof chinadns-ng)
dns2tcp_pid=$(pidof dns2tcp)

# update dnsmasq-china-list
update-china-list.sh

wait
set +eu
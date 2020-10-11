#! /bin/sh

echo "Clearing iptables..."
# Remove TCP
if [ $OUTPUT_CHAIN_REROUTE -eq 1 ]
then
    iptables -t nat -D OUTPUT -p tcp -j TPROXY-TCP
fi
iptables -t nat -D PREROUTING -p tcp -s 192.168/16 -j TPROXY-TCP
iptables -t nat -F TPROXY-TCP
iptables -t nat -X TPROXY-TCP

#Remove UDP
iptables -t mangle -D PREROUTING -p udp -s 192.168/16 -j TPROXY-UDP
iptables -t mangle -F TPROXY-UDP
iptables -t mangle -X TPROXY-UDP

#Remove route rule
ip route del local 0/0 dev lo table 100
ip rule del fwmark 0xff table 100

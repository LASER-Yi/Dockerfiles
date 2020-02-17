#! /bin/sh

iptables -t nat -D OUTPUT -p tcp -j SS-TCP
iptables -t nat -D PREROUTING -p tcp -s 192.168/16 -j SS-TCP
iptables -t nat -F TPROXY-TCP
iptables -t nat -X TPROXY-TCP

iptables -t mangle -D PREROUTING -p udp -s 192.168/16 -j SS-UDP
iptables -t mangle -F TPROXY-UDP
iptables -t mangle -X TPROXY-UDP

ip route del local 0/0 dev lo table 100
ip rule del fwmark 0xff table 100

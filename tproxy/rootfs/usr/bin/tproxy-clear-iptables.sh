#! /bin/sh

iptables -t nat -D OUTPUT -p tcp -j SS-TCP
iptables -t nat -D PREROUTING -p tcp -s 192.168/16 -j SS-TCP
iptables -t nat -F SS-TCP
iptables -t nat -X SS-TCP

iptables -t mangle -D PREROUTING -p udp -s 192.168/16 -j SS-UDP
iptables -t mangle -F SS-UDP
iptables -t mangle -X SS-UDP

ip route del local 0/0 dev lo table 100
ip rule del fwmark 0xff table 100

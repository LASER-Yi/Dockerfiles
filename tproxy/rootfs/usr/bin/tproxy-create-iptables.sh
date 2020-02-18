#! /bin/sh
#
# Create iptables rule

echo "Creating new iptables rule..."
ip rule add fwmark 0xff table 100
ip route add local 0/0 dev lo table 100
# UDP
iptables -t mangle -N TPROXY-UDP
# pass local address
iptables -t mangle -A TPROXY-UDP -d 0/8 -j RETURN
iptables -t mangle -A TPROXY-UDP -d 127/8 -j RETURN
iptables -t mangle -A TPROXY-UDP -d 10/8 -j RETURN
iptables -t mangle -A TPROXY-UDP -d 169.254/16 -j RETURN
iptables -t mangle -A TPROXY-UDP -d 172.16/12 -j RETURN
iptables -t mangle -A TPROXY-UDP -d 192.168/16 -j RETURN
iptables -t mangle -A TPROXY-UDP -d 224/4 -j RETURN
iptables -t mangle -A TPROXY-UDP -d 240/4 -j RETURN
# custom iptables rule
sh /config/custom-udp-rule.sh
# pass proxy server port
iptables -t mangle -A TPROXY-UDP -p udp --dport $SERVER_PORT -j RETURN
# chnip rule and custom ipset rule
iptables -t mangle -A TPROXY-UDP -m set --match-set chnip dst -j RETURN
iptables -t mangle -A TPROXY-UDP -m set --match-set custom_direct dst -j RETURN
# redir rule
iptables -t mangle -A TPROXY-UDP -p udp -j TPROXY --tproxy-mark 0xff --on-ip 127.0.0.1 --on-port $REDIR_PORT
# re-routing flow
iptables -t mangle -A PREROUTING -p udp -s 192.168/16 -j TPROXY-UDP

# TCP
iptables -t nat -N TPROXY-TCP
# pass local address
iptables -t nat -A TPROXY-TCP -d 0/8 -j RETURN
iptables -t nat -A TPROXY-TCP -d 127/8 -j RETURN
iptables -t nat -A TPROXY-TCP -d 10/8 -j RETURN
iptables -t nat -A TPROXY-TCP -d 169.254/16 -j RETURN
iptables -t nat -A TPROXY-TCP -d 172.16/12 -j RETURN
iptables -t nat -A TPROXY-TCP -d 192.168/16 -j RETURN
iptables -t nat -A TPROXY-TCP -d 224/4 -j RETURN
iptables -t nat -A TPROXY-TCP -d 240/4 -j RETURN
# custom iptables rule
sh /config/custom-tcp-rule.sh
# pass proxy server port
iptables -t nat -A TPROXY-TCP -p tcp --dport $SERVER_PORT -j RETURN
# chnip rule and custom ipset rule
iptables -t nat -A TPROXY-TCP -m set --match-set chnip dst -j RETURN
iptables -t nat -A TPROXY-TCP -m set --match-set custom_direct dst -j RETURN
# redir rule
iptables -t nat -A TPROXY-TCP -p tcp -j REDIRECT --to-ports $REDIR_PORT
# re-routing flow
iptables -t nat -A OUTPUT -p tcp -j TPROXY-TCP
iptables -t nat -A PREROUTING -p tcp -s 192.168/16 -j TPROXY-TCP

# enable gateway
iptables -t nat -A POSTROUTING -s 192.168/16 -j MASQUERADE

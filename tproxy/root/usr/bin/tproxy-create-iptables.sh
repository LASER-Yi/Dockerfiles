#! /bin/sh
#
# Create iptables rule

echo "Creating new iptables rule..."
ip rule add fwmark 0xff table 100
ip route add local 0/0 dev lo table 100


# === UDP === 
iptables -t mangle -N TPROXY-UDP
iptables -t mangle -F TPROXY-UDP
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

if [ $OUTPUT_CHAIN_REROUTE -eq 1 ]
then
    # pass proxy server port
    iptables -t mangle -A TPROXY-UDP -p udp --dport $SERVER_PORT -j RETURN
fi

if [ $CHNROUTE_MODE -eq 1 ]
then
    # chnroute rule and custom ipset rule
    iptables -t mangle -A TPROXY-UDP -m set --match-set custom_direct dst -j RETURN
    iptables -t mangle -A TPROXY-UDP -p udp -m set --match-set custom_proxy dst -j TPROXY --tproxy-mark 0xff --on-ip 127.0.0.1 --on-port $REDIR_PORT
    iptables -t mangle -A TPROXY-UDP -m set --match-set chnroute4 dst -j RETURN
    # iptables -t mangle -A TPROXY-UDP -m set --match-set chnroute6 dst -j RETURN
fi
# redir rule
iptables -t mangle -A TPROXY-UDP -p udp -j TPROXY --tproxy-mark 0xff --on-ip 127.0.0.1 --on-port $REDIR_PORT
# re-routing flow
iptables -t mangle -A PREROUTING -p udp -s 192.168/16 -j TPROXY-UDP

# === TCP ===
iptables -t nat -N TPROXY-TCP
iptables -t nat -F TPROXY-TCP
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

if [ $OUTPUT_CHAIN_REROUTE -eq 1 ]
then
    # pass proxy server port
    iptables -t nat -A TPROXY-TCP -p tcp --dport $SERVER_PORT -j RETURN
fi

if [ $CHNROUTE_MODE -eq 1 ]
then
    # chnroute rule and custom ipset rule
    iptables -t nat -A TPROXY-TCP -m set --match-set custom_direct dst -j RETURN
    iptables -t nat -A TPROXY-TCP -p tcp -m set --match-set custom_proxy dst -j REDIRECT --to-ports $REDIR_PORT
    iptables -t nat -A TPROXY-TCP -m set --match-set chnroute4 dst -j RETURN
    # iptables -t nat -A TPROXY-TCP -m set --match-set chnroute6 dst -j RETURN
fi

# redir rule
iptables -t nat -A TPROXY-TCP -p tcp -j REDIRECT --to-ports $REDIR_PORT
# re-routing flow
if [ $OUTPUT_CHAIN_REROUTE -eq 1 ]
then
    iptables -t nat -A OUTPUT -p tcp -j TPROXY-TCP
fi

iptables -t nat -A PREROUTING -p tcp -s 192.168/16 -j TPROXY-TCP

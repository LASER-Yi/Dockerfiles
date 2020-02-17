# custom your udp filter for iptables
# write iptables rule direct down below
# iptables -t mangle -A TPROXY-UDP -p udp --sport 6881 -j RETURN
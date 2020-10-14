FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="TProxy-Tun" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY root /

RUN apk add --no-cache ipset iptables curl \
    && chmod +x /usr/bin/start-tun /usr/bin/stop-tun

ENV TUN_DEVICE_NAME="utun" \
    TUN_IPCIDR=198.18.0.0/16 \
    TUN_IP_ADDRESS=198.18.0.1 \
    MTU=9000 \
    LOCAL_CIDR="192.168.0.0/16" \
    ROUTE_TABLE=100 \
    FWMARK=114514

ENTRYPOINT [ "/usr/bin/start-tun" ]

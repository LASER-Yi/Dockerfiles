FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="TProxy-Tun" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY root /

RUN apk add --no-cache ipset iptables curl \
    && chmod +x /usr/bin/start-tun /usr/bin/stop-tun

ENV TUN_DEVICE_NAME="utun" \
    MTU=1480 \
    LOCAL_CIDR="192.168.0.0/16" \
    ROUTE_TABLE=100 \
    FWMARK=114514

ENTRYPOINT [ "/usr/bin/start-tun" ]

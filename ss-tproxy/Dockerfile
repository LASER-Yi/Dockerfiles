FROM alpine:latest as builder

RUN mkdir /build-package \
    && apk add --no-cache git build-base linux-headers \
    && git clone https://github.com/zfl9/chinadns-ng \
    && cd chinadns-ng \
    && make \
    && mkdir -p /build-package/usr/local/bin && cp chinadns-ng /build-package/usr/local/bin \
    && cd / \
    # config
    && git clone https://github.com/zfl9/ss-tproxy && cd ss-tproxy \
    && chmod +x ss-tproxy \
    && cp -af ss-tproxy /build-package/usr/local/bin \
    && mkdir -p /build-package/etc/ss-tproxy \
    && cp -af ss-tproxy.conf gfwlist* chnroute* ignlist* /build-package/etc/ss-tproxy 

FROM ly0007/shadowsocks-libev:latest

COPY --from=builder  /build-package  /

RUN apk add --no-cache \
    bash        \
    curl        \
    perl        \
    ipset       \
    dnsmasq     \
    iptables    \
    iproute2

# update build-in list
RUN ss-tproxy update-gfwlist \
    && ss-tproxy update-chnroute \
    && ss-tproxy update-chnlist \
    && ss-tproxy restart \
    && tail -f /var/log/ssr-redir.log 

VOLUME /etc/ss-tproxy

CMD [ "ss-tproxy start" ]
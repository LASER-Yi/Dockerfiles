FROM alpine:latest as builder

ENV DNS_VER 1.3.2
ENV DNS_URL https://github.com/clowwindy/ChinaDNS/releases/download/${DNS_VER}/chinadns-${DNS_VER}.tar.gz
ENV DNS_FILE chinadns.tar.gz

RUN mkdir /build-package \
    && apk add --no-cache curl git build-base linux-headers

RUN mkdir chinadns \
    && cd chinadns \
    && curl -sSL ${DNS_URL} -o ${DNS_FILE} \
    && tar -xzf ${DNS_FILE} --strip 1 \
    && sh configure && make install \
    && mkdir -p /build-package/usr/local/bin \
    && cp /usr/local/bin/chinadns /build-package/usr/local/bin \
    && mkdir -p /build-package/backup \
    && cp chnroute.txt /build-package/backup \
    && cd / \
    ## download dnsmasq-china-list
    && mkdir -p /build-package/backup/dnsmasq.d/ \
    && git clone --depth=1 https://github.com/felixonmars/dnsmasq-china-list.git \
    && cp /dnsmasq-china-list/dnsmasq-update-china-list /build-package/usr/local/bin \
    && cp /dnsmasq-china-list/*.conf /build-package/backup/dnsmasq.d/

FROM alpine:latest

COPY rootfs /
COPY --from=builder  /build-package  /

RUN apk add --no-cache dnsmasq \
    && chmod +x /usr/bin/entrypoint.sh

EXPOSE 53
VOLUME /config

ENTRYPOINT [ "entrypoint.sh" ]
FROM alpine:latest as builder

RUN mkdir /build-package \
    && apk add --no-cache curl git build-base linux-headers openssl-dev

RUN git clone https://github.com/pymumu/smartdns.git \
    && cd smartdns \
    && make \
    && mkdir -p /build-package/usr/local/bin \
    && cp /smartdns/src/smartdns /build-package/usr/local/bin \
    && mkdir -p /build-package/backup \
    && cp /smartdns/etc/smartdns/smartdns.conf /build-package/backup \
    && cd /

FROM alpine:latest

COPY rootfs /
COPY --from=builder  /build-package  /

RUN apk add --no-cache dnsmasq openssl \
    && chmod +x /usr/bin/entrypoint.sh

EXPOSE 53
VOLUME /config

ENTRYPOINT [ "entrypoint.sh" ]
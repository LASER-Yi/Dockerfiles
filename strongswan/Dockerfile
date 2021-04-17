#
# StrongSwan VPN + Alpine Linux Based on stanback/alpine-strongswan-vpn:latest
#

FROM alpine:latest

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        curl \
        curl-dev \
        iptables-dev \
        linux-headers \
        openssl-dev && \
    mkdir -p /tmp/strongswan && \
    curl -Lo /tmp/strongswan.tar.bz2 https://download.strongswan.org/strongswan-5.9.2.tar.bz2 && \
    tar --strip-components=1 -C /tmp/strongswan -xjf /tmp/strongswan.tar.bz2 && \
    cd /tmp/strongswan && \
    ./configure --prefix=/usr --sysconfdir=/config --libexecdir=/usr/lib --with-ipsecdir=/usr/lib/strongswan \
        --enable-chapoly \
        --enable-cmd \
        --enable-curl \
        --enable-dhcp \
        --enable-eap-dynamic \
        --enable-eap-identity \
        --enable-eap-md5 \
        --enable-eap-mschapv2 \
        --enable-eap-radius \
        --enable-eap-tls \
        --enable-farp \
        --enable-files \
        --enable-gcm \
        --enable-md4 \
        --enable-newhope \
        --enable-ntru \
        --enable-openssl \
        --enable-sha3 \
        --enable-shared \
        --disable-aes \
        --disable-des \
        --disable-gmp \
        --disable-hmac \
        --disable-ikev1 \
        --disable-md5 \
        --disable-rc2 \
        --disable-sha1 \
        --disable-sha2 \
        --disable-static && \
    make && make install && \
    apk del .build-deps && \
    apk add --no-cache \
        iptables \
        ip6tables \
        iproute2 \
        curl \
        openssl && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

EXPOSE 500/udp \
       4500/udp

VOLUME /config

ENTRYPOINT ["/usr/sbin/ipsec"]
CMD ["start", "--nofork"]
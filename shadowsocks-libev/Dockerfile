FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="Shadowsocks-libev" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

RUN apk add --no-cache --virtual .build-deps \
    git \
    build-base \
    autoconf \
    automake \
    c-ares-dev \
    libcap \
    libev-dev \
    libtool \
    libsodium-dev \
    linux-headers \
    mbedtls-dev \
    pcre-dev \
    && git clone https://github.com/shadowsocks/shadowsocks-libev.git \
    && cd shadowsocks-libev \
    && git submodule init && git submodule update \
    && sh autogen.sh \
    && sh configure --prefix=/usr --disable-documentation \
    && make install \
    && apk del .build-deps \
    # Check runtime dependencies
    && apk add --no-cache \
    ca-certificates \
    rng-tools \
    $(scanelf --needed --nobanner /usr/bin/ss-* \
    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    | sort -u) \
    && rm -rf /shadowsocks-libev
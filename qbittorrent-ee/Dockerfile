FROM alpine:latest as compileOS

ENV QBITTORRENT_VERSION=4.3.1.11 \
    LIBTORRENT_VERSION=1.2.11

ADD https://github.com/c0re100/qBittorrent-Enhanced-Edition/archive/release-${QBITTORRENT_VERSION}.zip /
ADD https://github.com/arvidn/libtorrent/releases/download/v${LIBTORRENT_VERSION}/libtorrent-rasterbar-${LIBTORRENT_VERSION}.tar.gz /

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk add --no-cache ca-certificates build-base boost-dev qt5-qtsvg-dev qt5-qttools-dev qt5-qtbase-dev file \
&&  mkdir /sources

# libtorrent
RUN tar -xvf $(find . -name libtorrent-*) -C /sources \
&&  cd /sources && cd $(find . -name libtorrent-*) \
&&  ./configure --disable-debug --enable-encryption CXXFLAGS="-std=c++17" \
&&  make -j$(nproc) install-strip \
&&  cd /

# qBittorrent-Enhanced-Edition
RUN unzip $(find . -name release-*) -d /sources \
&&  cd /sources && cd $(find . -name qBittorrent-*) \
&&  ./configure --disable-gui --disable-stacktrace CXXFLAGS="-std=c++17" \
&&  make -j$(nproc) install \
&&  cd /

# copy dependence and other stuff
RUN ldd /usr/local/bin/qbittorrent-nox | cut -d ">" -f 2 | grep lib | cut -d "(" -f 1|xargs tar -chvf /sources/qbittorrent.tar \
&&  mkdir /qbittorrent \
&&  tar -xvf /sources/qbittorrent.tar -C /qbittorrent \
&&  cp --parents /usr/local/bin/qbittorrent-nox /qbittorrent

# setup run env
COPY rootfs /qbittorrent

RUN cd /qbittorrent \
&&  chmod a+x usr/local/bin/qbittorrent-nox init

# RunOS
FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="qBittorrent-ee" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

ENV WEBUI_PORT=8989 \
    PEER_PORT=6881 \
    UID=1000 \
    GID=1000 \
    UMASK=022 \
    TZ=Asia/Shanghai

COPY --from=compileOS  /qbittorrent  /

RUN apk add --no-cache tzdata curl s6 \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

VOLUME /config

# donot expose port cause we are using host network
EXPOSE $WEBUI_PORT  $PEER_PORT  $PEER_PORT/udp

ENTRYPOINT "/init"

HealthCheck --interval=60s --timeout=3s --retries=3 \
    CMD curl -m 5 -fs http://localhost:{$WEBUI_PORT} || exit 1

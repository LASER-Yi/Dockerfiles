FROM alpine:latest as compilerOS

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="qBittorrent-ee" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

ENV QBITTORRENT_VERSION=4.2.5.14

COPY buildfs /

RUN apk add --no-cache ca-certificates build-base qt5-qtsvg-dev boost-dev qt5-qttools-dev file curl \
&&  chmod a+x /download.sh && sh /download.sh && mkdir /qbtorrent \
&&  tar -zxf /libtorrent.tar.gz -C /qbtorrent \
&&  cd /qbtorrent \
&&  mv $(find . -name libtorrent-*) libtorrent \
&&  cd libtorrent \
&&  ./configure --disable-debug --enable-encryption CXXFLAGS="-std=c++14" \
&&  make -j$(nproc) install-strip \
# qBittorrent-Enhanced-Edition
&&  unzip -q /qbitttorrent-ee.zip -d /qbtorrent \
&&   cd  /qbtorrent \
&&   mv $(find . -name qBittorrent-*) qbittorrent-ee \
&&   cd  qbittorrent-ee \
&&   ./configure --disable-gui --disable-stacktrace CXXFLAGS="-std=c++14" \
&&   make -j$(nproc) install \
# copy dependence and other stuff
&&   ldd /usr/local/bin/qbittorrent-nox |cut -d ">" -f 2|grep lib|cut -d "(" -f 1|xargs tar -chvf /qbtorrent/qbittorrent.tar \
&&   mkdir /qbittorrent \
&&   tar -xvf /qbtorrent/qbittorrent.tar -C /qbittorrent \
&&   cp --parents /usr/local/bin/qbittorrent-nox /qbittorrent

# setup run env
COPY rootfs /qbittorrent
RUN cd /qbittorrent \
&&  chmod a+x usr/local/bin/qbittorrent-nox usr/bin/entrypoint.sh

# RunOS
FROM alpine:latest

ENV WEBUI_PORT=8989 \
    PEER_PORT=6881 \
    UID=1000 \
    GID=1000 \
    TZ=Asia/Shanghai

COPY --from=compilerOS  /qbittorrent  /

VOLUME /downloads /config

# donot expose port cause we are using host network
# EXPOSE $WEBUI_PORT  $PEER_PORT  $PEER_PORT/udp

ENTRYPOINT [ "entrypoint.sh" ]

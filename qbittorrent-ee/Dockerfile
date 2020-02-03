FROM alpine:latest as compilerOS

COPY buildfs /

RUN apk add --no-cache ca-certificates make g++ gcc qt5-qtsvg-dev boost-dev qt5-qttools-dev file curl \
&&  chmod a+x /download.sh && sh /download.sh && mkdir /qbtorrent \
&&  tar -zxf /libtorrent.tar.gz -C /qbtorrent \
&&  cd /qbtorrent \
&&  mv $(find . -name libtorrent-*) libtorrent \
&&  cd libtorrent \
&&  ./configure --disable-debug --enable-encryption CXXFLAGS="-std=c++14" \
&&  make -j$(nproc) install-strip
# qBittorrent-Enhanced-Edition
RUN  unzip -q /qbitttorrent-ee.zip -d /qbtorrent \
&&   cd  /qbtorrent \
&&   mv $(find . -name qBittorrent-*) qbittorrent-ee \
&&   cd  qbittorrent-ee \
&&   ./configure   --disable-gui \
&&   make -j$(nproc) install \
&&   ldd /usr/local/bin/qbittorrent-nox   |cut -d ">" -f 2|grep lib|cut -d "(" -f 1|xargs tar -chvf /qbtorrent/qbittorrent.tar  \
&&   mkdir /qbittorrent   \
&&   tar  -xvf /qbtorrent/qbittorrent.tar   -C  /qbittorrent   \
&&   cp --parents /usr/local/bin/qbittorrent-nox  /qbittorrent


# RunOS
FROM alpine:latest

ENV WEBUI_PORT=8989
ENV PEER_PORT=6881
ENV UID 1000
ENV GID 1000

COPY rootfs /
COPY --from=compilerOS  /qbittorrent  /

# install dependance
RUN apk add --no-cache ca-certificates \
&&  rm -rf /var/cache/apk/* \
%%  rm -rf /tmp/* \
&&  chmod a+x  /usr/local/bin/qbittorrent-nox /usr/bin/entrypoint.sh

VOLUME /downloads /config
EXPOSE $WEBUI_PORT  $PEER_PORT  $PEER_PORT/udp

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

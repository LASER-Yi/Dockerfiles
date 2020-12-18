FROM alpine:latest as compileOS

ENV QBITTORRENT_VERSION=4.3.1.11

COPY buildfs /

# qBittorrent-Enhanced-Edition
RUN chmod +x /download.sh \
    && /download.sh \
    && unzip qbittorrent.zip \
    && mkdir /qbittorrent \
    && cp /qbittorrent-nox /qbittorrent

# setup run env
COPY rootfs /qbittorrent

RUN cd /qbittorrent \
&&  chmod a+x qbittorrent-nox init

# RunOS
FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="qBittorrent-EE" \
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
    && rm -rf /tmp/* \
    && mv qbittorrent-nox /usr/local/bin

VOLUME /config

# donot expose port cause we are using host network
EXPOSE $WEBUI_PORT  $PEER_PORT  $PEER_PORT/udp

ENTRYPOINT "/init"

HealthCheck --interval=60s --timeout=3s --retries=3 \
    CMD curl -m 5 -fs http://localhost:{$WEBUI_PORT} || exit 1

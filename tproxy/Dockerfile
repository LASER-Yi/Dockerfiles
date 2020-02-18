FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="TProxy" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY rootfs /

ADD https://github.com/shadowsocks/ChinaDNS/raw/master/chnroute.txt /backup

RUN apk add --no-cache ipset iptables \
    && chmod +x /usr/bin/entrypoint.sh /usr/bin/tproxy-*

VOLUME /config

ENV REDIR_PORT=10800 \
    SERVER_PORT=10863

ENTRYPOINT [ "entrypoint.sh" ]
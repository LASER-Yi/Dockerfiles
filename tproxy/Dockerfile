FROM ly0007/chinadns_dnsmasq:latest

COPY rootfs /

RUN apk add --no-cache ipset iptables \
    && chmod +x /usr/bin/entrypoint.sh /usr/bin/tproxy-*

VOLUME /config

ENV REDIR_PORT=10800 \
    SERVER_PORT=10863

ENTRYPOINT [ "entrypoint.sh" ]
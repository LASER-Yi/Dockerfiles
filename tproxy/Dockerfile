FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="TProxy" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY rootfs /

RUN apk add --no-cache ipset iptables curl \
    && chmod +x /usr/bin/entrypoint.sh /usr/bin/tproxy-* \
    && curl -sSL 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' -o /tmp/chnip \
    && cat /tmp/chnip | grep ipv4 | grep CN | awk -F\| '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' > /backup/chnroute4.txt \
    && cat /tmp/chnip | grep ipv6 | grep CN | awk -F\| '{printf("%s/%d\n", $4, $5)}' > /backup/chnroute6.txt \
    && rm -rf /tmp/chnip

VOLUME /config

ENV REDIR_PORT=10800 \
    SERVER_PORT=10863 \
    CHNROUTE_MODE=0 \
    OUTPUT_CHAIN_REROUTE=0

ENTRYPOINT [ "entrypoint.sh" ]

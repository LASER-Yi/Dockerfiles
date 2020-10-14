FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="TProxy-Mangle" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY root /

RUN apk add --no-cache ipset iptables curl \
    && chmod +x /usr/bin/start-mangle /usr/bin/stop-mangle

ENV ROUTE_RULE=local \
    REDIR_ADDRESS=127.0.0.1 \
    REDIR_PORT=10800 \
    LOCAL_CIDR="192.168.0.0/16" \
    ROUTE_TABLE=100 \
    FWMARK=114514

ENTRYPOINT [ "/usr/bin/start-mangle" ]

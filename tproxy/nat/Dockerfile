FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="TProxy-NAT" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY root /

RUN apk add --no-cache iptables \
    && chmod +x /usr/bin/start-nat /usr/bin/stop-nat

ENV REDIR_PORT=10800 \
    LOCAL_CIDR="192.168.0.0/16"

ENTRYPOINT [ "/usr/bin/start-nat" ]

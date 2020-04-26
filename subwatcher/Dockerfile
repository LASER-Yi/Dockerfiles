FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="Subwatcher" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY rootfs /

RUN apk add --no-cache inotify-tools python3 libxml2 libxslt \
    && apk add --no-cache --virtual .build-deps libxml2-dev libxslt-dev build-base python3-dev libssl-dev \
    && pip3 install subfinder --no-cache-dir \
    && apk del .build-deps \
    && pip3 uninstall -y setuptools pip \
    && chmod 755 /usr/local/bin/subwatcher

VOLUME [ "/data" ]

ENV SUBFINDER_PARM=""

ENTRYPOINT [ "subwatcher", "/data" ]

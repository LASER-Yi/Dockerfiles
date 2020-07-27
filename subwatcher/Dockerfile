FROM alpine:latest

LABEL maintainer="ly0007@yeah.net" \
    org.label-schema.name="Subwatcher" \
    org.label-schema.vcs-url="https://github.com/LASER-Yi/Dockerfiles"

COPY rootfs /

RUN apk add --no-cache inotify-tools python3 py3-pip libxml2 libxslt libffi \
    && apk add --no-cache --virtual .build-deps libxml2-dev libxslt-dev build-base python3-dev libffi-dev \
    && pip3 install subfinder --no-cache-dir \
    && apk del .build-deps \
    && chmod 755 /usr/local/bin/subwatcher

VOLUME [ "/data" ]

ENV SUBFINDER_PARM=""

ENTRYPOINT [ "subwatcher", "/data" ]

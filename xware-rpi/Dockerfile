FROM debian:latest as downloader

ADD rootfs /

RUN apt-get update && apt-get install -y curl

# RUN curl -o xware.tar.gz https://raw.githubusercontent.com/snail007/xware/master/Xware_armel_v5te_glibc.tar.gz \
RUN  tar -zxvf xware.tar.gz -C /xware \
&&  rm xware.tar.gz \
&&  chmod +x /xware/portal \
&&  chmod +x /xware/monitor.sh


FROM gcr.io/distroless/cc-debian10:latest

COPY --from=downloader /xware /

WORKDIR /xware

VOLUME /Downloads

CMD [ "./monitor.sh" ]


FROM arm32v7/alpine as compilerOS

#compiling qB

ARG LIBTORRENT_VER=1.2.3
ARG BTORRENT_VER=4.2.1.10

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
&& apk add --no-cache ca-certificates make g++ gcc qt5-qtsvg-dev boost-dev qt5-qttools-dev file git

ADD libtorrent-rasterbar-${LIBTORRENT_VER}.tar.gz \qbtorrent

# RUN   wget -P /qbtorrent https://github.com/arvidn/libtorrent/releases/download/libtorrent-rasterbar-${LIBTORRENT_VER}.tar.gz \
# &&   tar  -zxvf  /qbtorrent/libtorrent-rasterbar-${LIBTORRENT_VER}.tar.gz   -C    /qbtorrent  \
RUN   cd  /qbtorrent/libtorrent-rasterbar-${LIBTORRENT_VER} \
&&   ./configure \
&&   make -j4 install-strip


#qBittorrent-Enhanced-Edition

ADD release-4.2.1.10.zip /qbtorrent

# RUN  wget  -P /qbtorrent https://github.com/c0re100/qBittorrent-Enhanced-Edition/archive/release-4.2.1.10.zip   \
RUN  cd  /qbtorrent/qBittorrent-Enhanced-Edition-release-${BTORRENT_VER} \
&&   ./configure   --disable-gui \
&&   make -j4 install \
&&   ldd /usr/local/bin/qbittorrent-nox   |cut -d ">" -f 2|grep lib|cut -d "(" -f 1|xargs tar -chvf /qbtorrent/qbittorrent.tar  \
&&   mkdir /qbittorrent   \
&&   tar  -xvf /qbtorrent/qbittorrent.tar   -C  /qbittorrent   \
&&   cp --parents /usr/local/bin/qbittorrent-nox  /qbittorrent
 

 # RunOS
FROM arm32v7/alpine:latest

ARG  S6_VER=1.22.1.0

ENV TRACKERSAUTO=YES
ENV TZ=Asia/Shanghai
ENV WEBUIPORT=8989

COPY root /
COPY --from=compilerOS  /qbittorrent  /

# install bash curl caddy tzdata s6 overlay python3
RUN  wget --no-check-certificate https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-amdhf.tar.gz  \
&&   tar -xvzf s6-overlay-amdhf.tar.gz  \
&&   rm s6-overlay-amdhf.tar.gz   \
&&   apk add --no-cache bash curl ca-certificates  tzdata  python3 \
&&   rm -rf /var/cache/apk/*   \
&&   chmod a+x  /usr/local/bin/qbittorrent-nox  


VOLUME /Downloads /config
EXPOSE 8989  6881  6881/udp
ENTRYPOINT [ "qbittorrent-nox"]
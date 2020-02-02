FROM alpine as compilerOS

#compiling qB

ARG LIBTORRENT_VER=1.2.3
ARG BTORRENT_VER=4.2.1.10

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
&& apk add --no-cache ca-certificates make g++ gcc qt5-qtsvg-dev boost-dev qt5-qttools-dev file git

ADD libtorrent-rasterbar-${LIBTORRENT_VER}.tar.gz \qbtorrent

# RUN   wget -P /qbtorrent https://github.com/arvidn/libtorrent/releases/download/libtorrent-rasterbar-${LIBTORRENT_VER}.tar.gz \
# &&   tar  -zxvf  /qbtorrent/libtorrent-rasterbar-${LIBTORRENT_VER}.tar.gz   -C    /qbtorrent  \
RUN   cd  /qbtorrent/libtorrent-rasterbar-${LIBTORRENT_VER} \
&&   ./configure --disable-debug --enable-encryption CXXFLAGS="-std=c++14"\
&&   make -j2 install-strip


#qBittorrent-Enhanced-Edition

ADD release-4.2.1.10.zip /qbtorrent

# RUN  wget  -P /qbtorrent https://github.com/c0re100/qBittorrent-Enhanced-Edition/archive/release-4.2.1.10.zip   \
RUN  cd  /qbtorrent/qBittorrent-Enhanced-Edition-release-${BTORRENT_VER} \
&&   ./configure   --disable-gui \
&&   make -j2 install \
&&   ldd /usr/local/bin/qbittorrent-nox   |cut -d ">" -f 2|grep lib|cut -d "(" -f 1|xargs tar -chvf /qbtorrent/qbittorrent.tar  \
&&   mkdir /qbittorrent   \
&&   tar  -xvf /qbtorrent/qbittorrent.tar   -C  /qbittorrent   \
&&   cp --parents /usr/local/bin/qbittorrent-nox  /qbittorrent
 

 # RunOS
FROM alpine:latest

ENV TZ=Asia/Shanghai
ENV WEBUIPORT=8989

COPY root /
COPY --from=compilerOS  /qbittorrent  /

# install dependance
RUN  apk add --no-cache bash curl ca-certificates tzdata \
&&   rm -rf /var/cache/apk/*   \
&&   chmod a+x  /usr/local/bin/qbittorrent-nox


VOLUME /Downloads /config
EXPOSE 8989  6881  6881/udp
ENTRYPOINT [ "entrypoint.sh"]
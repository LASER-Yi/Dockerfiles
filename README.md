# Dockerfiles
![CI](https://github.com/LASER-Yi/Dockerfiles/workflows/CI/badge.svg)
![QB](https://github.com/LASER-Yi/Dockerfiles/workflows/qBittorrent/badge.svg)
![SS](https://github.com/LASER-Yi/Dockerfiles/workflows/Shadowsocks-libev/badge.svg)
![CD](https://github.com/LASER-Yi/Dockerfiles/workflows/Chinadns_Dnsmasq/badge.svg)
![TP](https://github.com/LASER-Yi/Dockerfiles/workflows/TProxy/badge.svg)

🐳 A collection of Dockerfile build for raspberrypi and other platforms

Link to [Docker HUB](https://hub.docker.com/u/ly0007)

> All images in this repo support following CPU architecture:
> * arm32v6
> * arm32v7
> * arm64v8
> * amd64

### qBittorrent-ee
> qBittorrent-Enhanced-Edition multi-arch support

Quick Setup

```
docker volume create qbittorrent_config
```
```
docker run -d --name qbittorrent \
--net host
-v qbittorrent_config:/config \
-v /path/to/downloads:/downloads \
--restart Unless-stopped \
ly0007/qbittorrent-ee
```

If you need Python3 to drive search plugin, please download ``ly0007/qbittorrent-ee:latest-python3`` version

### Shadowsocks-libev
> Shadowsocks-libev multi-arch support

Both SS & SSR version are included in this image
```
docker pull ly0007/shadowsocks-libev:latest
```

```
docker pull ly0007/shadowsocks-libev:latest-ssr
```

### ChinaDNS+Dnsmasq
> All-in-One DNS Server using ChinaDNS

### TProxy
> All-in-One TProxy Gateway

Auto configurate TProxy to redirect incoming tcp socket and tproxy udp to given REDDIR_PORT port.

Quick Setup
```
docker run -d --name TProxy \
--net host
--cap-add NET_ADMIN
-e "REDIR_PORT=10800"
-e "SERVER_PORT=10863"
-v path/to/config:/config \
--restart Unless-stopped \
ly0007/tproxy
```

Deploy transparent proxy with Shadowsocks-libev

``` yml
version: '3' 
services: 
  ShadowsocksR:
    image: ly0007/shadowsocks-libev:latest-ssr
    command: ss-redir -c /config/ssr.json -u
    network_mode: "host"
    restart: unless-stopped
    volumes:
      - /etc/tproxy:/config
  TProxy:
    image: ly0007/tproxy
    cap_add:
      - NET_ADMIN
    network_mode: "host"
    restart: unless-stopped
    volumes:
      - /etc/tproxy:/config
  ChinaDNS-NG:
    image: ly0007/chinadns_dnsmasq:latest-ng
    cap_add:
      - NET_ADMIN
    network_mode: "host"
    restart: unless-stopped
    environment:
      CHINADNS_OPTION: -r
    volumes:
      - /etc/tproxy:/config
```

Deploy transparent proxy using Clash

```yml
version: '2' 
services: 
  Clash:
    image: dreamacro/clash:latest
    network_mode: "host"
    restart: unless-stopped
    volumes:
      - /etc/tproxy/clash:/root/.config/clash/
      - /etc/tproxy/clash-ui:/ui
  TProxy:
    image: ly0007/tproxy:latest
    cap_add:
      - NET_ADMIN
    network_mode: "host"
    volumes:
      - /etc/tproxy:/config
  SmartDNS:
    image: ly0007/smartdns:latest
    cap_add:
      - NET_ADMIN
    network_mode: "host"
    restart: unless-stopped
    volumes:
      - /etc/tproxy:/config
```

**This Image will modify your iptables and ipset, please make sure NET_ADMIN is enable**

### Subwatcher
> Subtitle auto-download program base on [Subfinder](https://github.com/ausaki/subfinder)

Quick Setup
```
docker run -d --name Subwatcher \
-v path/to/folder:/data \
--restart Unless-stopped \
ly0007/subwatcher
```
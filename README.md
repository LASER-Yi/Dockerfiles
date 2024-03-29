# Dockerfiles
![QB](https://github.com/LASER-Yi/Dockerfiles/workflows/qBittorrent/badge.svg)
![SS](https://github.com/LASER-Yi/Dockerfiles/workflows/Shadowsocks-libev/badge.svg)
![TP](https://github.com/LASER-Yi/Dockerfiles/workflows/TProxy/badge.svg)
![SW](https://github.com/LASER-Yi/Dockerfiles/workflows/Subwatcher/badge.svg)

🐳 A collection of Dockerfile build for raspberrypi and other platforms

[Docker HUB](https://hub.docker.com/u/ly0007)

> All images in this repo support following CPU architecture:
> * arm32v6 (deprecated)
> * arm32v7
> * arm64v8
> * amd64

### qBittorrent-ee
> [qBittorrent-Enhanced-Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition)  multi-arch support

### Shadowsocks-libev
> Shadowsocks-libev multi-arch support

**No longer maintaind**

Both SS & SSR version are included in this image
```
docker pull ly0007/shadowsocks-libev:latest
```

```
docker pull ly0007/shadowsocks-libev:latest-ssr
```

### TProxy
> All-in-One TProxy Ruleset

Auto configurate TProxy to redirect incoming tcp socket and tproxy udp to given REDDIR_PORT port.

**This Image will modify your iptables and ipset, please make sure NET_ADMIN is enable**


### Subwatcher
> Subtitle auto-download program based on [Subfinder](https://github.com/ausaki/subfinder)

**No longer maintaind**

Quick Setup
```
docker run -d --name Subwatcher \
-v path/to/folder:/data \
--restart Unless-stopped \
ly0007/subwatcher
```
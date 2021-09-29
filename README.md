# Dockerfiles

![QB](https://github.com/LASER-Yi/Dockerfiles/workflows/qBittorrent/badge.svg)
![TP](https://github.com/LASER-Yi/Dockerfiles/workflows/TProxy/badge.svg)

🐳 A collection of Dockerfile build for raspberrypi and other platforms

[Docker HUB](https://hub.docker.com/u/ly0007)

> All images in this repo support following CPU architecture:
>
> - arm32v6 (deprecated)
> - arm32v7
> - arm64v8
> - amd64

### qBittorrent-ee

> [qBittorrent-Enhanced-Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition) multi-arch support

### TProxy

> All-in-One TProxy Ruleset

Auto configurate TProxy to redirect incoming tcp socket and tproxy udp to given REDDIR_PORT port.

**This Image will modify your iptables and ipset, please make sure NET_ADMIN is enable**

### Subwatcher

> Subtitle auto-download program based on [Subfinder](https://github.com/ausaki/subfinder)

**No longer maintained, please switch to Bazarr**

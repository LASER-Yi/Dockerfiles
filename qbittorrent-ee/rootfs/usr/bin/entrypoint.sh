#! /bin/sh
#
# entrypoint.sh

addgroup -g ${GID} qbittorrent
adduser -h /config -s /bin/sh -G qbittorrent -D -u ${UID} qbittorrent

mkdir -p /config/.config/qBittorrent

[[ ! -f /config/.config/qBittorrent/qBittorrent.conf ]] && cp /etc/qBittorrent/qBittorrent.conf /config/.config/qBittorrent/
sed -i "s|Connection\\\PortRangeMin=.*|Connection\\\PortRangeMin=${PEER_PORT}|i" /config/.config/qBittorrent/qBittorrent.conf
sed -i "s|Downloads\\\SavePath=.*|Downloads\\\SavePath=/downloads|i" /config/.config/qBittorrent/qBittorrent.conf

chown -R qbittorrent:qbittorrent /config
chown -R qbittorrent:qbittorrent /downloads

su qbittorrent -c "qbittorrent-nox --webui-port=${WEBUI_PORT}"

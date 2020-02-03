#! /bin/sh
#
# entrypoint.sh

sed -i "s|Connection\\\PortRangeMin=.*|Connection\\\PortRangeMin=${PEER_PORT}|i" /config/.config/qBittorrent/qBittorrent.conf
sed -i "s|Downloads\\\SavePath=.*|Downloads\\\SavePath=/downloads|i" /config/.config/qBittorrent/qBittorrent.conf

qbittorrent-nox --webui-port=$WEBUI_PORT
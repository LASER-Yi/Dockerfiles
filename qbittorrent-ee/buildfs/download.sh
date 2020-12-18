# !/bin/sh
ARCH=$(uname -m)

echo -e "${INFO} Check CPU architecture ..."
if [[ ${ARCH} == "x86_64" ]]; then
    ARCH="qbittorrent-nox_linux_x64_static"
elif [[ ${ARCH} == "armv7l" ]]; then
    ARCH="qbittorrent-nox_arm-linux-musleabi_static"
else
    echo -e "${ERROR} This architecture is not supported."
    exit 1
fi

wget -O /qbittorrent.zip https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/release-${QBITTORRENT_VERSION}/${ARCH}.zip
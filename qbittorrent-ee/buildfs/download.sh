
download_libtorrent_code()
{
    local file_path="/libtorrent.tar.gz"
    local download_url=$(curl -s https://api.github.com/repos/arvidn/libtorrent/releases/latest | grep 'browser_download_url' | grep 'tar.gz' | cut -d\" -f4)

    if ! curl -sSL -o "$file_path" $download_url; then
        echo "Download libtorrent fail.." && exit 1
    fi
}

download_qbittorrent_ee_code()
{
    local download_url="https://github.com/c0re100/qBittorrent-Enhanced-Edition/archive/release-$QBITTORRENT_VERSION.zip"

    local file_path="/qbitttorrent-ee.zip"
        if ! curl -sSL -o "$file_path" $download_url; then
        echo "Download qbittorrent fail.." && exit 1
    fi
}

download_libtorrent_code
download_qbittorrent_ee_code
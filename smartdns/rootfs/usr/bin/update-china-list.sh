# !/bin/sh
# Update china acceleration list from dnsmasq

DIRECTDNS_NAME="chinadns"

convertList() {
    url=$1
    tempFile=$(mktemp)
    filename=$(echo $url | sed 's/.*\///')
    curl -o $tempFile -sSL $url

    if [ $? -eq 0 ]
    then
        echo "Updating $filename..."
        middleFile=$(mktemp)

        sed -e 's|^server=\/\(.*\)\/.*$|\1|' $tempFile | egrep -v '^#' > $middleFile

        mkdir -p config/smartdns.d/
        sed -e "s|\(.*\)|nameserver /\1/$DIRECTDNS_NAME|" $middleFile > config/smartdns.d/$filename

        rm -f $middleFile
    fi

    rm -f $tempfile
}

convertList "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"

convertList "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf"

convertList "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf"
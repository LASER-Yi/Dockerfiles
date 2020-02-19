#! /bin/sh
#
# Update Dnsmasq-China-List

echo "Updating Dnsmasq-China-List..."

mkdir -p /config/dnsmasq.d/

curl -sSL https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf \
    -o /config/dnsmasq.d/accelerated-domains.china.conf

curl -sSL https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf \
    -o /config/dnsmasq.d/google.china.conf

curl -sSL https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf \
    -o /config/dnsmasq.d/apple.china.conf

curl -sSL https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/bogus-nxdomain.china.conf \
    -o /config/dnsmasq.d/bogus-nxdomain.china.conf

echo "Done"
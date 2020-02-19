#! /bin/sh
#
# entrypoint.sh

# create a daemon for tproxy

trap "sigterm_handler" TERM

sigterm_handler() {
echo "exiting..."
tproxy-stop.sh
exit 143;
}

# exit when fail
set -eu

# copy custom file if no exist
[[ ! -f /config/custom_direct.txt ]] && cp -r /backup/custom* /config

# update chnroute file
tproxy-update-chnroute.sh

# setup
chmod 755 /config/custom-*

# setting up tproxy iptables
tproxy-start.sh

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done

set +eu
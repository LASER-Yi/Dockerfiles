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

if [ $ENABLE_MINI_MODE -eq 0 ]
then
  # copy custom file if no exist
  [[ ! -f /config/custom_direct.txt ]] && cp -r /backup/custom* /config

  # copy ipset file if no exist
  [[ ! -f /config/chnroute4.txt ]] && cp -r /backup/chnroute4.txt /config
  [[ ! -f /config/chnroute6.txt ]] && cp -r /backup/chnroute6.txt /config
else
  # only update custom rule in ENABLE_MINI_MODE
  [[ ! -f /config/custom-tcp-rule.txt ]] && cp -r /backup/custom-* /config
fi
# setup
chmod 755 /config/custom-*



if [ $ENABLE_MINI_MODE -eq 0 ]
then
  # setting up tproxy iptables
  tproxy-start.sh
  # update chnroute file
  tproxy-update-chnroute.sh
else
  tproxy-mini-start.sh
fi

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done

set +eu
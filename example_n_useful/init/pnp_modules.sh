cat /sys/bus/pnp/devices/*/id | sed 's/.*/pnp:d&/' | while read ALIAS; do modprobe $ALIAS; done

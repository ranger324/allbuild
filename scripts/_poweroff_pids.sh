[ -z "$1" ] && exit 1

while true; do
    nobreak=0
    for i in $@; do
	[ -e /proc/$i ] && nobreak=1
    done
    [ "$nobreak" = "0" ] && break
    sleep 1
done
#poweroff
#reboot
_reinit -p && poweroff

[ -z "$1" ] && exit 1
mount --bind /dev $1/dev
mount --bind /sys $1/sys
mount --bind /proc $1/proc

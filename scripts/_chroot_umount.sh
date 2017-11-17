[ -z "$1" ] && exit 1
umount $1/dev
umount $1/sys
umount $1/proc

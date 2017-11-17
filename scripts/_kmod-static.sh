kmod static-nodes --format=devname | \
#exit 0
while read name devname rest; do
    devnum=$(echo $rest | tail -c +2)
    if echo "$devname" | grep -q "/"; then
	[ ! -d /dev/`dirname "$devname"` ] && mkdir -p /dev/`dirname "$devname"`
    fi
    mknod -m 0600 /dev/$devname $(echo $rest | head -c 1) $(echo $devnum | cut -d : -f 1) $(echo $devnum | cut -d : -f 2)
done

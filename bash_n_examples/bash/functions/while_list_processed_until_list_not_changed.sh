
cd /sys/devices

mods=`find -type f -name "modalias"`
num=`echo $mods | wc -l`
numold=
processed=

IFS=$'\n'
while [ "$num" != "$numold" ]; do
    numold=$num
    for mod in $mods; do
	if ! echo "$processed" | grep -q "^$mod$"; then
	    modprobe -qb "$(cat "$mod")"
	    [ -z "$processed" ] && processed="$mod" || processed=`echo -ne "$processed\n$mod"`
	fi
    done
    mods=`find -type f -name "modalias"`
    num=`echo "$mods" | wc -l`
done

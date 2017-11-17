#sort by depth in dirtree
#find /sys/devices -type f -name "modalias" -printf "%h\n" | \
find /sys/devices -path "/sys/devices/*" -type f -name "modalias" -printf "%2d/%h\n" | sort -r | cut -d / -f 2- | \
while read DIR; do
    ADIR=/sys/devices/
    RDIR=
    while [ "$ADIR$RDIR" != "$DIR" ]; do
	if [ -z "$RDIR" ]; then
	    SDIR=${DIR/$ADIR/}
	    RDIR=${SDIR%%/*}
	else
	    SDIR=${DIR/$ADIR$RDIR\//}
	    RDIR=$RDIR/${SDIR%%/*}
	fi
	[ -e "$ADIR$RDIR/modalias" ] && modprobe -q "$(cat "$ADIR$RDIR/modalias")"
    done
done

NUM="$1"
if [ -z "$NUM" ]; then
    DAEMONGRP=1000
else
    if echo "$NUM" | grep -q "[^[:digit:]]"; then
	echo "Parameter not numeric"
	exit 1
    else
	DAEMONGRP="$NUM"
    fi
fi

GRPS=`cat /etc/group | sort -n -k 3 -t : | cut -d : -f 3`

PREVGRP=$(expr $DAEMONGRP - 1)

for i in $GRPS; do
    [ $i -lt $DAEMONGRP ] && continue
    if [ $(expr $i - $PREVGRP) -ge 2 ]; then
	echo $(expr $PREVGRP + 1)
	exit 0
    else
	PREVGRP=$i
    fi
done
echo $(expr $i + 1)

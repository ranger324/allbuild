NUM="$1"
if [ -z "$NUM" ]; then
    DAEMONUSER=1000
else
    if echo "$NUM" | grep -q "[^[:digit:]]"; then
	echo "Parameter not numeric"
	exit 1
    else
	DAEMONUSER="$NUM"
    fi
fi

USERS=`cat /etc/passwd | sort -n -k 3 -t : | cut -d : -f 3`

PREVUSER=$(expr $DAEMONUSER - 1)

for i in $USERS; do
    [ $i -lt $DAEMONUSER ] && continue
    if [ $(expr $i - $PREVUSER) -ge 2 ]; then
	echo $(expr $PREVUSER + 1)
	exit 0
    else
	PREVUSER=$i
    fi
done
echo $(expr $i + 1)

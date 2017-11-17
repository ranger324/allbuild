if [ "$1" = "-f" ]; then
    for i in $(seq 1 50000); do
	echo "$i"
    done
else
    i=0
    while true; do
	i=$(expr $i + 1)
	echo "$i"
	[ "$i" = 5000 ] && break
    done
fi

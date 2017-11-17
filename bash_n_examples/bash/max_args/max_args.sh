getconf ARG_MAX

echo

xargs --show-limits &
LPID=$!
sendkeys $(tty) $'\004'
wait $LPID

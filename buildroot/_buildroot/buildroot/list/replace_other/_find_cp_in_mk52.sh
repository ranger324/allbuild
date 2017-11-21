#backslash group print (lines with \ at end of line)
sh _find_format_pattern%0.sh | \
while read line; do
    FILE=`echo "$line" | cut -d : -f 1`
    NUM=`echo "$line" | cut -d : -f 2`
    LINES=`wc -l "$FILE" | cut -d ' ' -f 1`
    echo "**$FILE:$NUM"
    while true; do
	NUM=$(expr $NUM - 1)
	[ "$NUM" = 0 ] && break
	LINE=`sed -n "${NUM}p" "$FILE"`
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done
    while true; do
	NUM=$(expr $NUM + 1)
	LINE=`sed -n "${NUM}p" "$FILE"`
	echo "$LINE"
	[ "$NUM" = "$LINES" ] && break
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done
done

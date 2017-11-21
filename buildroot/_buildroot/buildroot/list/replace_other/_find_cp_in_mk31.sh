#backslash group remark (lines with \ at end of line)
sh _find_format_pattern%0.sh > /tmp/file
exec 3< /tmp/file
while read -r -u 3 line; do
    FILE=`echo "$line" | cut -d : -f 1`
    NUM=`echo "$line" | cut -d : -f 2`
    ONUM="$NUM"
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
    read -r -s -N 1 -p "Remark section? (y/n):" remark
    echo
    if [ "$remark" = "y" ]; then
    while true; do
	ONUM=$(expr $ONUM - 1)
	[ "$ONUM" = 0 ] && break
	LINE=`sed -n "${ONUM}p" "$FILE"`
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done
    while true; do
	ONUM=$(expr $ONUM + 1)
	LINE=`sed -n "${ONUM}p" "$FILE"`
	sed -i "${ONUM}s/.*/#&/" "$FILE"
	[ "$ONUM" = "$LINES" ] && break
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done
    fi
done

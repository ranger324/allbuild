#backslash group remark (lines with \ at end of line)
sh _find_format_pattern.sh > /tmp/file
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

    LINE=`sed -n "$(expr $NUM + 1)p" "$FILE"`
    echo "$LINE" | grep "^[[:space:]]\+\$(" | grep -qv "^[[:space:]]\+\$([A-Z0-9a-z_]\+)" && EXPR=1 || EXPR=

    while true; do
	NUM=$(expr $NUM + 1)
	LINE=`sed -n "${NUM}p" "$FILE"`
	echo "$LINE"
	[ "$NUM" = "$LINES" ] && break
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done

    read -r -s -N 1 -p "Remark section? (y/n):" remark
    echo
    ####
    if [ "$remark" = "y" ]; then
    while true; do
	ONUM=$(expr $ONUM - 1)
	[ "$ONUM" = 0 ] && break
	LINE=`sed -n "${ONUM}p" "$FILE"`
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done
    if [ "$EXPR" = 1 ]; then
	NUM111=0
	NUM222=0
	ONUM=$(expr $ONUM + 1)
	LINE=`sed -n "${ONUM}p" "$FILE"`
	NUM11=`echo -n "$LINE" | sed 's/[^(]//g' | wc -c`
	NUM111=$(expr $NUM111 + $NUM11)
	NUM22=`echo -n "$LINE" | sed 's/[^)]//g' | wc -c`
	NUM222=$(expr $NUM222 + $NUM22)
	#if eq then sed
	if [ "$NUM111" = "$NUM222" ]; then
	    #if backslash at end but "(" ")" number ok
	    sed -i "${ONUM}s/.*/#&/" "$FILE"
	    if [ "$(expr $ONUM + 1)" -le "$LINES" ]; then
		ONUM="$(expr $ONUM + 1)"
		[ "$LINE" != "$(echo "$LINE" | sed 's%[\]$%%')" ] && sed -i "${ONUM}s/.*/#&/" "$FILE"
	    fi
	fi
	while [ "$NUM111" != "$NUM222" ]; do
	    sed -i "${ONUM}s/.*/#&/" "$FILE"
	    [ "$ONUM" = "$LINES" ] && break
	    ONUM=$(expr $ONUM + 1)
	    LINE=`sed -n "${ONUM}p" "$FILE"`
	    NUM11=`echo -n "$LINE" | sed 's/[^(]//g' | wc -c`
	    NUM111=$(expr $NUM111 + $NUM11)
	    NUM22=`echo -n "$LINE" | sed 's/[^)]//g' | wc -c`
	    NUM222=$(expr $NUM222 + $NUM22)
	    #if eq then sed
	    if [ "$NUM111" = "$NUM222" ]; then
		#if backslash at end but "(" ")" number ok
		sed -i "${ONUM}s/.*/#&/" "$FILE"
		if [ "$(expr $ONUM + 1)" -le "$LINES" ]; then
		    ONUM="$(expr $ONUM + 1)"
		    [ "$LINE" != "$(echo "$LINE" | sed 's%[\]$%%')" ] && sed -i "${ONUM}s/.*/#&/" "$FILE"
		fi
	    fi
	done
    else
	while true; do
	    ONUM=$(expr $ONUM + 1)
	    LINE=`sed -n "${ONUM}p" "$FILE"`
	    sed -i "${ONUM}s/.*/#&/" "$FILE"
	    [ "$ONUM" = "$LINES" ] && break
	    [ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
	done
    fi
    fi
done

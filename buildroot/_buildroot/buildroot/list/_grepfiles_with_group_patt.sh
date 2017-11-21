#echo "a123" | sort -k 1.2n
#[\]$
#\$(STAGING_DIR)\|\$(TARGET_DIR)
find -mindepth 2 -type f -name "*.mk" | \
while read line; do
    grep -Hn "\$(STAGING_DIR)\|\$(TARGET_DIR)" "$line"
done | \
while read -r line; do
    NNUM=0
    FILE=`echo "$line" | cut -d : -f 1`
    NUM=`echo "$line" | cut -d : -f 2`
    LINES=`wc -l "$FILE" | cut -d ' ' -f 1`
    #LINEE=`echo "$line" | cut -d : -f 3-`
    #[ "$OFILE" != "$FILE" ] && echo "---$FILE" && OFILE="$FILE"

    while true; do
	NUM=$(expr $NUM - 1)
	[ "$NUM" = 0 ] && break
	LINE=`sed -n "${NUM}p" "$FILE"`
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done
    while true; do
	NUM=$(expr $NUM + 1)
	LINE=`sed -n "${NUM}p" "$FILE"`
	echo "$FILE:$NUM:$LINE"
	[ "$NUM" = "$LINES" ] && break
	[ "$LINE" = "$(echo "$LINE" | sed 's%[\]$%%')" ] && break
    done
done

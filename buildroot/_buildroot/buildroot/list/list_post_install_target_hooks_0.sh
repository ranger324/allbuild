omkfile=
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read -r mkfile; do
    grep -n "^.*_INSTALL_TARGET_HOOKS[[:space:]]\+[+=]" "$mkfile" | \
    while read -r AA DECB DECC; do
	[ "$omkfile" != "$mkfile" ] && echo "$mkfile" && omkfile="$mkfile"
	MULTILINE=
	[ "$DECC" != "$(echo "$DECC" | sed 's%[\]$%%')" ] && MULTILINE=1 && DECC=$(echo "$DECC" | sed 's%[\]$%%')
	ACT_GREP_LINE=`echo "$AA" | cut -d : -f 1`
	DECA=`echo "$AA" | cut -d : -f 2-`
	echo "$DECA $DECB $DECC"
	if [ "$MULTILINE" = "1" ]; then
	    NUM=0
	    while true; do
		NUM=`expr $NUM + 1`
		NEXTLINE=$(expr $ACT_GREP_LINE + $NUM)
		LINE=`head -n "$NEXTLINE" $mkfile | tail -n 1`
		LINE_RE=`echo "$LINE" | sed 's%[\]$%%'`
		echo "$LINE_RE"
		[ "$LINE" = "$LINE_RE" ] && break
	    done
	fi
    done
done

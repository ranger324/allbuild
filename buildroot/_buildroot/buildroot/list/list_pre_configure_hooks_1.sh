omkfile=
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read -r mkfile; do
    grep -n "^.*_PRE_CONFIGURE_HOOKS[[:space:]]\+[+=]" "$mkfile" | \
    while read -r AA DECB DECC; do
	[ "$omkfile" != "$mkfile" ] && echo "---$mkfile" && omkfile="$mkfile"
	MULTILINE=
	[ "$DECC" != "$(echo "$DECC" | sed 's%[\]$%%')" ] && MULTILINE=1 && DECC=$(echo "$DECC" | sed 's%[\]$%%')
	ACT_GREP_LINE=`echo "$AA" | cut -d : -f 1`
	DECA=`echo "$AA" | cut -d : -f 2-`

#	echo "$DECA $DECB *$DECC*"
	if [ -z "$DECC" ]; then
	    echo "<-$DECA $DECB"
	    #echo
	else
	    echo "<-$DECA $DECB $DECC"
	    #echo
	    for i in "$DECC"; do
		if echo "$i" | grep -q "^\$("; then
		    echo "->$i"
		    echo
		    continue
		fi
		echo "->$i"
		sh _find_file_section.sh -q "$mkfile" "^define[[:space:]]\+$i" "^endef"
		echo
	    done
	fi

	if [ "$MULTILINE" = "1" ]; then
	    NUM=0
	    while true; do
		NUM=`expr $NUM + 1`
		NEXTLINE=$(expr $ACT_GREP_LINE + $NUM)
		LINE=`head -n "$NEXTLINE" "$mkfile" | tail -n 1`
		LINE_RE=`echo "$LINE" | sed 's%[\]$%%'`
		#echo "$LINE_RE"
		CMD=`echo $LINE_RE`
		if echo "$CMD" | grep -q "^\$("; then
		    echo "->$CMD"
		    echo
		else
		    echo "->$CMD"
		    sh _find_file_section.sh -q "$mkfile" "^define[[:space:]]\+$CMD" "^endef"
		    echo
		fi
		[ "$LINE" = "$LINE_RE" ] && break
	    done
	fi
    done
done

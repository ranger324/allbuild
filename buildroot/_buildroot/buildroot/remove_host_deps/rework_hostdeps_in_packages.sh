find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" | \
while read mkfile; do
    grep -n "^.*_DEPENDENCIES[[:space:]]\+[+=]" $mkfile | grep -v "^[0-9]\+:HOST_" | \
    while read -r AA DECB DECC; do
	MULTILINE=
	[ "$DECC" != "$(echo "$DECC" | tr -d '\' 2> /dev/null)" ] && MULTILINE=1 && DECC=$(echo "$DECC" | tr -d '\' 2> /dev/null)
	ACT_GREP_LINE=`echo $AA | cut -d : -f 1`
	DECA=`echo $AA | cut -d : -f 2-`

	case $DECA in
	    *)
		DEC1="$DECA"
	    ;;
	esac
	case $DECB in
	    =)
		DEC2="="
	    ;;
	    +=)
		DEC2="+="
	    ;;
	    *)
		DEC2="$DECB"
	    ;;
	esac
	DEC3=
	for i in $DECC; do
	    case $i in
		host-*)
		    j=`echo $i | sed 's/^host-//'`
		;;
		\$\(*)
		    j=`echo $i | sed 's/,host-/,/g'`
		;;
		*)
		    j="$i"
		;;
	    esac
	    [ -z "$DEC3" ] && DEC3="$j" || DEC3="$DEC3 $j"
	done

	if [ "$MULTILINE" = "1" ]; then
	    :
	    sed -i "s/$DECA[[:space:]]\+$DECB[[:space:]]\+$DECC/$DEC1 $DEC2 $DEC3 /" $mkfile
#	    sed -i "s/$DECA[[:space:]]\+$DECB[[:space:]]\+$DECC/$DEC1 $DEC2 $DEC3 /" $mkfile
	else
	    :
	    sed -i "s/$DECA[[:space:]]\+$DECB[[:space:]]\+$DECC/$DEC1 $DEC2 $DEC3/" $mkfile
#	    sed -i "s/$DECA[[:space:]]\+$DECB[[:space:]]\+$DECC/$DEC1 $DEC2 $DEC3/" $mkfile
	fi
	
	if [ "$MULTILINE" = "1" ]; then
	    NUM=0
	    while true; do
		NUM=`expr $NUM + 1`
		LINE=`head -n $(expr $ACT_GREP_LINE + $NUM) $mkfile | tail -n 1`
		LINE_RE=`echo "$LINE" | tr -d '\' 2> /dev/null`
		REPLACE=`echo "$LINE_RE" | sed -e 's/host-//g'`
echo $LINE_RE
		sed -i "s/^$LINE_RE/$REPLACE/" $mkfile
#		sed -i "s/^$LINE_RE/$REPLACE/" $mkfile
		[ "$LINE" = "$LINE_RE" ] && break
	    done
	fi
    done

done

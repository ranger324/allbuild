find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read mkfile; do

    grep -n "^.*_DEPENDENCIES[[:space:]]\+[+=]" $mkfile | grep -v "^[0-9]\+:HOST_" | \
    while read -r AA DECB DECC; do
	PKGNAME=$(basename $(dirname $mkfile))
	MULTILINE=
	#echo "$DECC" | tr -d '\' 2> /dev/null
	#echo "$DECC" | sed 's%[\]$%%'
	#echo "${DECC%\\}"
	#last char backslash string a\b\b\ give value to variable: (\")
	#A="a\b\b\\"
	#replace backslash or delete
	#echo "${A//\\/}"; echo "${A//a/\\}"

	[ "$DECC" != "$(echo "$DECC" | tr -d '\' 2> /dev/null)" ] && MULTILINE=1 && DECC=$(echo "$DECC" | tr -d '\' 2> /dev/null)
	ACT_GREP_LINE=`echo "$AA" | cut -d : -f 1`
	DECA=`echo "$AA" | cut -d : -f 2-`

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
	DECO=
	for i in $DEC3; do
	    case $i in
		autoconf-tgt)
		    j="autoconf"
		;;
		automake-tgt)
		    j="automake"
		;;
		\$\(*)
		    j=`echo $i | sed -e 's/,autoconf-tgt/,autoconf/g' -e 's/,automake-tgt/,automake/g'`
		;;
		*)
		    j="$i"
		;;
	    esac
	    [ -z "$DECO" ] && DECO="$j" || DECO="$DECO $j"
	done

echo $mkfile
echo $DEC1 $DEC2 $DEC3
	if [ "$MULTILINE" = "1" ]; then

	sed -i "s/$DECA[[:space:]]\+$DECB[[:space:]]\+$DECC/$DEC1 $DEC2 $DECO /" $mkfile
	else

	sed -i "s/$DECA[[:space:]]\+$DECB[[:space:]]\+$DECC/$DEC1 $DEC2 $DECO/" $mkfile
	fi
	
	if [ "$MULTILINE" = "1" ]; then
	    NUM=0
	    while true; do
		NUM=`expr $NUM + 1`
		LINE=`head -n $(expr $ACT_GREP_LINE + $NUM) $mkfile | tail -n 1`
		LINE_RE=`echo "$LINE" | tr -d '\' 2> /dev/null`
#		REPLACE=`echo "$LINE_RE" | sed -e 's/host-//g'`

	REPLACE=
	for i in $LINE_RE; do
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
	    [ -z "$REPLACE" ] && REPLACE="$j" || REPLACE="$REPLACE $j"
	done

	REPLACO=
	for i in $REPLACE; do
	    case $i in
		autoconf-tgt)
		    j="autoconf"
		;;
		automake-tgt)
		    j="automake"
		;;
		\$\(*)
		    j=`echo $i | sed -e 's/,autoconf-tgt/,autoconf/g' -e 's/,automake-tgt/,automake/g'`
		;;
		*)
		    j="$i"
		;;
	    esac
	    [ -z "$REPLACO" ] && REPLACO="$j" || REPLACO="$REPLACO $j"
	done


echo $LINE_RE
		if [ "$LINE" = "$LINE_RE" ]; then
		    sed -i "s/^$LINE_RE/$REPLACO/" $mkfile
		else
		    sed -i "s/^$LINE_RE/$REPLACO /" $mkfile
		fi
		
		[ "$LINE" = "$LINE_RE" ] && break
	    done
	fi
    done

done

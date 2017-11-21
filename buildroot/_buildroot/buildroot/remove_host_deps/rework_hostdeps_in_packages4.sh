GREPPATTERN='\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)'
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


	[ "$DECC" != "$(echo "$DECC" | sed 's%[\]$%%')" ] && MULTILINE=1 && DECC=$(echo "$DECC" | sed 's%[\]$%%')

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


echo $mkfile
echo "DEPORIG<-$DECA $DECB $DECC*"
echo "*"
echo "*\$DECC:$DECC"
##
DEC3=
if echo "$DECC" | grep -qo "$GREPPATTERN"; then
echo "**"
OIFS=$IFS
IFS=$'\n'
ifdeps=`echo "$DECC" | grep -o "$GREPPATTERN"`
echo "ifdeps->$ifdeps"
for line in $ifdeps; do
echo "if->$line"
    PKGS=`echo "$line" | sed -e 's/[^,]\+,//' -e 's/)$//'`
    OIFS=$IFS
    IFS=$' ,\t'
    DEPIF=
    for i in $PKGS; do
	[ -z "$i" ] && continue
	case "$i" in
	    host-*)
		j=`echo "$i" | sed 's/^host-//'`
	    ;;
	    *)
		j="$i"
	    ;;
	esac
	[ -z "$DEPIF" ] && DEPIF="$j" || DEPIF="$DEPIF,$j"
    done
    IFS=$OIFS
    IFDEF=`echo "$line" | sed -e 's/\$([[:space:]]*if[[:space:]]\+\$(//' -e 's/)[[:space:]]*,.*//'`
    #
    [ -z "$DEC3" ] && DEC3="\$(if \$($IFDEF),$DEPIF)" || DEC3="$DEC3 \$(if \$($IFDEF),$DEPIF)"
done
IFS=$OIFS
for i in `echo "$DECC" | sed 's/\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)//g'`; do
echo "if_notif->$i"
    case "$i" in
	host-*)
	    j=`echo "$i" | sed 's/^host-//'`
	;;
	*)
	    j="$i"
	;;
    esac
    #
    [ -z "$DEC3" ] && DEC3="$j" || DEC3="$DEC3 $j"
done
else
echo "***"
    for i in $DECC; do
echo "nonif->$i"
	case "$i" in
	    host-*)
		j=`echo "$i" | sed 's/^host-//'`
	    ;;
	    *)
		j="$i"
	    ;;
	esac
	#
	[ -z "$DEC3" ] && DEC3="$j" || DEC3="$DEC3 $j"
    done
fi

#	DECO=
#	for i in $DEC3; do
#	    case $i in
#		autoconf-tgt)
#		    j="autoconf"
#		;;
#		automake-tgt)
#		    j="automake"
#		;;
#		*)
#		    j="$i"
#		;;
#	    esac
#	    [ -z "$DECO" ] && DECO="$j" || DECO="$DECO $j"
#	done

echo "DEPLINE->$DEC1 $DEC2 $DEC3"

	if [ "$MULTILINE" = "1" ]; then
#	    sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DECO \\\/" $mkfile
	    sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DEC3 \\\/" $mkfile
	else
#	    sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DECO/" $mkfile
	    sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DEC3/" $mkfile
	fi
	
	if [ "$MULTILINE" = "1" ]; then
	    NUM=0
	    while true; do
		NUM=`expr $NUM + 1`
		NEXTLINE=$(expr $ACT_GREP_LINE + $NUM)
		LINE=`head -n "$NEXTLINE" $mkfile | tail -n 1`
		LINE_RE=`echo "$LINE" | sed 's%[\]$%%'`


REPLACE=
if echo "$LINE_RE" | grep -qo "$GREPPATTERN"; then
OIFS=$IFS
IFS=$'\n'

ifdeps=`echo "$LINE_RE" | grep -o "$GREPPATTERN"`
echo "ifdeps->$ifdeps"
for line in $ifdeps; do
#echo "->$line"
    PKGS=`echo "$line" | sed -e 's/[^,]\+,//' -e 's/)$//'`
    OIFS=$IFS
    IFS=$' ,\t'
    DEPIF=
    for i in $PKGS; do
	[ -z "$i" ] && continue
	case "$i" in
	    host-*)
		j=`echo "$i" | sed 's/^host-//'`
	    ;;
	    *)
		j="$i"
	    ;;
	esac
	[ -z "$DEPIF" ] && DEPIF="$j" || DEPIF="$DEPIF,$j"
    done
    IFS=$OIFS
    IFDEF=`echo "$line" | sed -e 's/\$([[:space:]]*if[[:space:]]\+\$(//' -e 's/)[[:space:]]*,.*//'`
    #
    [ -z "$REPLACE" ] && REPLACE="\$(if \$($IFDEF),$DEPIF)" || REPLACE="$REPLACE \$(if \$($IFDEF),$DEPIF)"
done
IFS=$OIFS
for i in `echo "$LINE_RE" | sed 's/\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)//g'`; do
    case "$i" in
	host-*)
	    j=`echo "$i" | sed 's/^host-//'`
	;;
	*)
	    j="$i"
	;;
    esac
    #
    [ -z "$REPLACE" ] && REPLACE="$j" || REPLACE="$REPLACE $j"
done
else
    for i in $LINE_RE; do
	case "$i" in
	    host-*)
		j=`echo "$i" | sed 's/^host-//'`
	    ;;
	    *)
		j="$i"
	    ;;
	esac
	#
	[ -z "$REPLACE" ] && REPLACE="$j" || REPLACE="$REPLACE $j"
    done
fi

#	REPLACO=
#	for i in $REPLACE; do
#	    case $i in
#		autoconf-tgt)
#		    j="autoconf"
#		;;
#		automake-tgt)
#		    j="automake"
#		;;
#		\$\(*)
#		    j=`echo $i | sed -e 's/,autoconf-tgt/,autoconf/g' -e 's/,automake-tgt/,automake/g'`
#		;;
#		*)
#		    j="$i"
#		;;
#	    esac
#	    [ -z "$REPLACO" ] && REPLACO="$j" || REPLACO="$REPLACO $j"
#	done


echo "LINE<-$LINE_RE"
echo "LINE->$REPLACE"
		if [ "$LINE" = "$LINE_RE" ]; then
		    sed -i "${NEXTLINE}s/.*/$REPLACE/" $mkfile
		else
		    sed -i "${NEXTLINE}s/.*/$REPLACE \\\/" $mkfile
		fi
		
		[ "$LINE" = "$LINE_RE" ] && break
	    done
	fi
    done

done

procdeps()
{
procifdep()
{
local str="$@"
echo "$str" | grep -o "\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)" | \
while read -r line; do
#echo "*$line" >&2
    PKGS=`echo "$line" | sed -e 's/[^,]\+,//' -e 's/)$//'`
#echo "**$PKGS" >&2
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
#echo "***$j" >&2
	[ -z "$DEPIF" ] && DEPIF="$j" || DEPIF="$DEPIF,$j"
    done
    IFS=$OIFS
    IFDEF=`echo "$line" | sed -e 's/\$([[:space:]]*if[[:space:]]\+\$(//' -e 's/)[[:space:]]*,.*//'`
    ##
    #check
    echo -n "\$(if \$($IFDEF),$DEPIF) "
done
}


origstr="$@"
if echo "$origstr" | grep -qo "\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)"; then


#added=`(procifdep "$origstr" 2>&3 >&4) 3>&1`
procifdep "$origstr"
#echo "$added" > pipe

for i in `echo "$origstr" | sed 's/\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)//g'`; do
    case "$i" in
	host-*)
	    j=`echo "$i" | sed 's/^host-//'`
	;;
	*)
	    j="$i"
	;;
    esac
    #
    echo -n "$j "
done
else
    for i in $origstr; do
	case "$i" in
	    host-*)
		j=`echo "$i" | sed 's/^host-//'`
	    ;;
	    *)
		j="$i"
	    ;;
	esac
	#
	echo -n "$j "
    done
fi
}

exec 4>&1 3>&1
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
echo "DEPORIG<-$DECA $DECB $DECC"

#	pkgadded=
#	[ ! -p pipe ] && mkfifo pipe
#	while read -r pkgline; do
#	    [ -z "$pkgadded" ] && pkgadded="$pkgline" || pkgadded=`echo -ne "$pkgadded\n$pkgline"`
#	done < pipe &
#	readpid=$!
	DEC3=`procdeps "$DECC"`
	DEC3=${DEC3::${#DEC3}-1}
#	wait $readpid
#	echo "$pkgadded"

echo "DEPLINE->$DEC1 $DEC2 $DEC3"
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

		REPLACE=`procdeps "$LINE_RE"`
		REPLACE=${REPLACE::${#REPLACE}-1}

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

exec 4>&- 3>&-

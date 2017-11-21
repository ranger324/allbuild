GREPPATTERN='\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)'
procdeps()
{
origstr="$@"
outstr=
if echo "$origstr" | grep -qo "$GREPPATTERN"; then
ifdeps=`echo "$origstr" | grep -o "$GREPPATTERN"`
IFS1=$IFS
IFS=$'\n'
for line in $ifdeps; do
    PKGS=`echo "$line" | sed -e 's/[^,]\+,//' -e 's/)$//'`

    IFS2=$IFS
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
	#
	if [ "$j" != "$PKGNAME" ]; then
	    [ -z "$DEPIF" ] && DEPIF="$j" || DEPIF="$DEPIF,$j"
	fi
    done
    IFS=$IFS2
    IFDEF=`echo "$line" | sed -e 's/\$([[:space:]]*if[[:space:]]\+\$(//' -e 's/)[[:space:]]*,.*//'`
    ##
    if [ ! -z "$DEPIF" ]; then
	[ -z "$outstr" ] && outstr="\$(if \$($IFDEF),$DEPIF)" || outstr="$outstr \$(if \$($IFDEF),$DEPIF)"
    fi
done
IFS=$IFS1
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
    echo "$addednoif" | grep -qx "$j" && continue
    if [ "$j" != "$PKGNAME" ]; then
	[ -z "$outstr" ] && outstr="$j" || outstr="$outstr $j"
	[ -z "$addednoif" ] && addednoif="$j" || addednoif=`echo -ne "$addednoif\n$j"`
    fi
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
	echo "$addednoif" | grep -qx "$j" && continue
	if [ "$j" != "$PKGNAME" ]; then
	    [ -z "$outstr" ] && outstr="$j" || outstr="$outstr $j"
	    [ -z "$addednoif" ] && addednoif="$j" || addednoif=`echo -ne "$addednoif\n$j"`
	fi
    done
fi
}

echo -n > /tmp/file

find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read mkfile; do
    grep -n "^.*_DEPENDENCIES[[:space:]]\+[+=]" $mkfile | grep -v "^[0-9]\+:HOST_" | \
    while read -r AA DECB DECC; do
	PKGNAME=$(basename $(dirname $mkfile))
	MULTILINE=
	addednoif=

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

	procdeps "$DECC"
	DEC3="$outstr"

echo "DEPLINE->$DEC1 $DEC2 $DEC3"

	if [ "$MULTILINE" = "1" ]; then
#	    sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DECO \\\/" $mkfile
	    if [ -z "$DEC3" ]; then
		sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 \\\/" $mkfile
	    else
		sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DEC3 \\\/" $mkfile
	    fi
	else
#	    sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DECO/" $mkfile
	    if [ -z "$DEC3" ]; then
		sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2/" $mkfile
	    else
		sed -i "${ACT_GREP_LINE}s/.*/$DEC1 $DEC2 $DEC3/" $mkfile
	    fi
	fi
	
	if [ "$MULTILINE" = "1" ]; then
	    NUM=0
	    while true; do
		NUM=`expr $NUM + 1`
		NEXTLINE=$(expr $ACT_GREP_LINE + $NUM)
		LINE=`head -n "$NEXTLINE" $mkfile | tail -n 1`
		LINE_RE=`echo "$LINE" | sed 's%[\]$%%'`

		procdeps "$LINE_RE"
		REPLACE="$outstr"

echo "LINE<-$LINE_RE"
echo "LINE->$REPLACE"

		if [ "$LINE" = "$LINE_RE" ]; then
#		    sed -i "${NEXTLINE}s/.*/$REPLACE/" $mkfile
		    if [ -z "$REPLACE" ]; then
			echo "$mkfile:$NEXTLINE" >> /tmp/file
			sed -i "${NEXTLINE}s/.*/$REPLACE/" $mkfile
		    else
			sed -i "${NEXTLINE}s/.*/$REPLACE/" $mkfile
		    fi
		else
#		    sed -i "${NEXTLINE}s/.*/$REPLACE \\\/" $mkfile
		    if [ -z "$REPLACE" ]; then
			echo "$mkfile:$NEXTLINE" >> /tmp/file
			sed -i "${NEXTLINE}s/.*/$REPLACE \\\/" $mkfile
		    else
			sed -i "${NEXTLINE}s/.*/$REPLACE \\\/" $mkfile
		    fi
		fi
		
		[ "$LINE" = "$LINE_RE" ] && addednoif= && break
	    done
	fi
    done
done


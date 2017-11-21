#printall
##IFS not to read "words" without spaces
IFS=
sh _find_descriptions.sh | \
while read -r line; do
case "$line" in
---*/Config.in*)
    #echo "$line"
    NNUM=0
    PKG=`echo "$line" | sed -e 's%^---%%' -e 's%/.*%%'`
    NUM=`echo "$line" | cut -d : -f 2- | sed 's%[[:space:]]*\*$%%'`
    FILE=`echo "$line" | sed -e 's%^---%%' -e 's%:.*%%'`
    #[ "$OFILE" != "$FILE" ] && OFILE="$FILE"
;;
*)
    NNUM=$(expr $NNUM + 1)
    LINE="$line"

    if echo "$LINE" | grep -q '^[[:space:]]\+bool[[:space:]]\+"'; then
	alias=`echo "$LINE" | sed 's/.*"\(.*\)".*/\1/'`
	GREP=`echo "$PKG" | sed 's/[-_]/\[ _-\]/g'`
	LNUM=$(expr $NUM + $NNUM - 1)
	if echo "$alias" | grep -q "^$GREP$"; then
	    echo "$FILE:$LNUM:$PKG:\"$alias\":1"
	else
	    if echo "$alias" | grep -q "^$GREP"; then
		echo "$FILE:$LNUM:$PKG:\"$alias\":2"
	    fi
	fi
    fi
;;
esac
done

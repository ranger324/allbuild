ONUM=0
#sh _find_cp_in_mk16.sh | sort -u -t : -k 1,1 -k 2,2n | \
sh _grepfiles_with_group_patt.sh | sort -u -t : -k 1,1 -k 2n | \
while read -r line; do
    FILE=`echo "$line" | cut -d : -f 1`
    NUM=`echo "$line" | cut -d : -f 2`
    LINE=`echo "$line" | cut -d : -f 3-`
    if [ "$OFILE" != "$FILE" ]; then
	echo "---$FILE:$NUM"
	OFILE="$FILE"
	echo "$LINE"
	ONUM="$NUM"
    else
	if [ "$(expr $NUM - 1)" = "$ONUM" ]; then
	    echo "$LINE"
	    ONUM="$NUM"
	else
	    echo "---$FILE:$NUM"
	    echo "$LINE"
	    ONUM="$NUM"
	fi
    fi
done

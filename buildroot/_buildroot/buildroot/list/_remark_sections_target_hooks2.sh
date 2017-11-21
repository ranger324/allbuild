#backslash group remark (lines with \ at end of line)
sh _find_format_pattern_target_hooks.sh > /tmp/file
exec 3< /tmp/file
while read -r -u 3 line; do
    file=`echo "$line" | cut -d : -f 1`
    num=`echo "$line" | cut -d : -f 2`
    onum="$num"
    numline=`wc -l "$file" | cut -d ' ' -f 1`
    echo "**$file:$num"
    while true; do
	num=$(expr $num - 1)
	[ "$num" = 0 ] && break
	line=`sed -n "${num}p" "$file"`
	[ "$line" = "$(echo "$line" | sed 's%[\]$%%')" ] && break
    done

    line=`sed -n "$(expr $num + 1)p" "$file"`
    echo "$line" | grep "^[[:space:]]\+\$(" | grep -qv "^[[:space:]]\+\$([A-Z0-9a-z_]\+)" && expr=1 || expr=

    while true; do
	num=$(expr $num + 1)
	line=`sed -n "${num}p" "$file"`
	echo "$line"
	[ "$num" = "$numline" ] && break
	[ "$line" = "$(echo "$line" | sed 's%[\]$%%')" ] && break
    done

    #read -r -s -N 1 -p "Remark section? (y/n):" remark
    remark=y
    #echo
    ####
    if [ "$remark" = "y" ]; then
    while true; do
	onum=$(expr $onum - 1)
	[ "$onum" = 0 ] && break
	line=`sed -n "${onum}p" "$file"`
	[ "$line" = "$(echo "$line" | sed 's%[\]$%%')" ] && break
    done
    if [ "$expr" = 1 ]; then
	scnum1=0
	scnum2=0
	onum=$(expr $onum + 1)
	line=`sed -n "${onum}p" "$file"`
	cnum1=`echo -n "$line" | sed 's/[^(]//g' | wc -c`
	scnum1=$(expr $scnum1 + $cnum1)
	cnum2=`echo -n "$line" | sed 's/[^)]//g' | wc -c`
	scnum2=$(expr $scnum2 + $cnum2)
	#if eq then sed
	if [ "$scnum1" = "$scnum2" ]; then
	    #if backslash at end but "(" ")" number ok
	    sed -i "${onum}s/.*/#&/" "$file"
	    if [ "$(expr $onum + 1)" -le "$numline" ]; then
		onum="$(expr $onum + 1)"
		[ "$line" != "$(echo "$line" | sed 's%[\]$%%')" ] && sed -i "${onum}s/.*/#&/" "$file"
	    fi
	fi
	while [ "$scnum1" != "$scnum2" ]; do
	    sed -i "${onum}s/.*/#&/" "$file"
	    [ "$onum" = "$numline" ] && break
	    onum=$(expr $onum + 1)
	    line=`sed -n "${onum}p" "$file"`
	    cnum1=`echo -n "$line" | sed 's/[^(]//g' | wc -c`
	    scnum1=$(expr $scnum1 + $cnum1)
	    cnum2=`echo -n "$line" | sed 's/[^)]//g' | wc -c`
	    scnum2=$(expr $scnum2 + $cnum2)
	    #if eq then sed
	    if [ "$scnum1" = "$scnum2" ]; then
		#if backslash at end but "(" ")" number ok
		sed -i "${onum}s/.*/#&/" "$file"
		if [ "$(expr $onum + 1)" -le "$numline" ]; then
		    onum="$(expr $onum + 1)"
		    [ "$line" != "$(echo "$line" | sed 's%[\]$%%')" ] && sed -i "${onum}s/.*/#&/" "$file"
		fi
	    fi
	done
    else
	while true; do
	    onum=$(expr $onum + 1)
	    line=`sed -n "${onum}p" "$file"`
	    sed -i "${onum}s/.*/#&/" "$file"
	    [ "$onum" = "$numline" ] && break
	    [ "$line" = "$(echo "$line" | sed 's%[\]$%%')" ] && break
	done
    fi
    fi
done

CM1="\"Graphic libraries and applications (graphic/text)\""
CM2="\"Fonts, cursors, icons, sounds and themes\""
CM3="\"Shell and utilities\""

cp Config.in Config.in.tmp
patch -p0 < Config.in.tmp.patch > /dev/null
cat Config.in.tmp | \
while read cmd rest; do
    case "$cmd" in
	menu)
	    [ -z "$menustr" ] && menustr="$rest" || menustr=`echo -ne "$menustr\n$rest"`
	    tmpmenu1="$rest"
	;;
	endmenu)
	    [ -z "$menustr" ] && echo "err"
	    menustr=`echo "$menustr" | head -n -1`
	;;
	comment)
	    case "$tmpmenu1" in
	    "$CM1"|"$CM2"|"$CM3")
		num=$(echo "$menustr" | wc -l)
		if [ "$num" -ge 1 ]; then
		    menustr=`echo "$menustr" | sed "${num}s/.*/$rest/"`
		fi
	    ;;
	    esac
	;;
    esac

    case "$cmd" in
	\#*|if|menu|endmenu|endif|depends|comment|"")
	    continue
	;;
    esac

    LAST=`echo "$menustr" | tail -n 1`
    [ -z "$LAST" ] && continue
    echo "$LAST $cmd $rest"
done

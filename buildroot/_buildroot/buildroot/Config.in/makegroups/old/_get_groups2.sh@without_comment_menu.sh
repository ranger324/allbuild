
cp Config.in Config.in.tmp
patch -p0 < Config.in.tmp.patch > /dev/null
cat Config.in.tmp | \
while read cmd rest; do
    case "$cmd" in
	menu)
	    [ -z "$menustr" ] && menustr="$rest" || menustr=`echo -ne "$menustr\n$rest"`
	;;
	endmenu)
	    [ -z "$menustr" ] && echo "err"
	    menustr=`echo "$menustr" | head -n -1`
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

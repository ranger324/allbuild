
num=0
cp Config.in Config.in.tmp
patch -p0 < Config.in.tmp.patch > /dev/null
(cat Config.in.tmp; echo "-endmenu-") | \
while read cmd rest; do
    case "$cmd" in
	menu)
	    [ -z "$menustr" ] && menustr="$rest" || menustr=`echo -ne "$menustr\n$rest"`
	    num=$(expr $num + 1)
	;;
	endmenu)
	    if [ "$num" -ge 1 ]; then
		menustr=`echo "$menustr" | head -n -1`
		num=$(expr $num - 1)
	    else
		echo "**Nummenu error**" && exit 1
	    fi
	;;
	-endmenu-)
	    [ "$num" -ne 0 ] && echo "**Nummenu error**"
	    #don't exit
	;;
    esac

    [ "$num" -lt 1 ] && continue

    case "$cmd" in
	\#*|if|menu|endmenu|endif|depends|comment|"")
	    continue
	;;
    esac

    LAST=`echo "$menustr" | tail -n 1`
    [ -z "$LAST" ] && echo "**Zero menu**" && exit 1
    echo "$LAST $cmd $rest"
done

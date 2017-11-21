
num=0
cd x11r7
cp Config.in Config.in.tmp
(cat Config.in.tmp; echo "-endmenu-") | \
while read cmd rest; do
    case "$cmd" in
	menu)
	    num=$(expr $num + 1)
	    eval menustr${num}="$rest"
	    tmpmenu1="$rest"
	;;
	endmenu)
	    if [ "$num" -ge 1 ]; then
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

    LAST=$(eval echo '$'menustr${num})
    [ -z "$LAST" ] && echo "**Zero menu**" && exit 1
    echo "\"$LAST\" $cmd $rest"
done

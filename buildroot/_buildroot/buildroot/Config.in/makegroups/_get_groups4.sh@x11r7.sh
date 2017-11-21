
declare -a menustr
num=-1
cd x11r7
cp Config.in Config.in.tmp
(cat Config.in.tmp; echo "-endmenu-") | \
while read cmd rest; do
    case "$cmd" in
	menu)
	    num=$(($num + 1))
	    menustr[${num}]="$rest"
	;;
	endmenu)
	    if [ "$num" -ge 0 ]; then
		num=$(($num - 1))
	    else
		echo "**Nummenu error**" && exit 1
	    fi
	;;
	-endmenu-)
	    [ "$num" -ne -1 ] && echo "**Nummenu error**"
	    #don't exit
	;;
    esac

    [ "$num" -lt 0 ] && continue

    case "$cmd" in
	\#*|if|menu|endmenu|endif|depends|comment|"")
	    continue
	;;
    esac

    [ -z "${menustr[${num}]}" ] && echo "**Zero menu**" && exit 1
    echo "${menustr[${num}]} $cmd $rest"
done

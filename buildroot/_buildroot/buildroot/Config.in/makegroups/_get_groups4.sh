CM1="\"Graphic libraries and applications (graphic/text)\""
CM2="\"Fonts, cursors, icons, sounds and themes\""
CM3="\"Shell and utilities\""

declare -a menustr
num=-1
cp Config.in Config.in.tmp
patch -p0 < Config.in.tmp.patch > /dev/null
(cat Config.in.tmp; echo "-endmenu-") | \
while read cmd rest; do
    case "$cmd" in
	menu)
	    num=$(($num + 1))
	    menustr[${num}]="$rest"
	    tmpmenu1="$rest"
	;;
	endmenu)
	    if [ "$num" -ge 0 ]; then
		num=$(($num - 1))
	    else
		echo "**Nummenu error**" && exit 1
	    fi
	;;
	comment)
	    case "$tmpmenu1" in
	    "$CM1"|"$CM2"|"$CM3")
		if [ "$num" -ge 0 ]; then
		    menustr[${num}]="$rest"
		fi
	    ;;
	    esac
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

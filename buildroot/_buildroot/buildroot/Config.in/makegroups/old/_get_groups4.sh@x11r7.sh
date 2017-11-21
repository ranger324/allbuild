
declare -a menustr
num=-1
cd x11r7
cp Config.in Config.in.tmp
cat Config.in.tmp | \
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
		echo "err"
	    fi
	;;
    esac

    [ "$num" -lt 0 ] && continue

    case "$cmd" in
	\#*|if|menu|endmenu|endif|depends|comment|"")
	    continue
	;;
    esac

    [ -z "${menustr[${num}]}" ] && continue
    echo "${menustr[${num}]} $cmd $rest"
done

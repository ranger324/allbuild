
num=0
cd x11r7
cp Config.in Config.in.tmp
cat Config.in.tmp | \
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
		echo "err"
	    fi
	;;
    esac

    [ "$num" -lt 1 ] && continue

    case "$cmd" in
	\#*|if|menu|endmenu|endif|depends|comment|"")
	    continue
	;;
    esac

    eval LAST=\$menustr${num}
    [ -z "$LAST" ] && continue
    echo "\"$LAST\" $cmd $rest"
done

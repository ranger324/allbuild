CM1="\"Graphic libraries and applications (graphic/text)\""
CM2="\"Fonts, cursors, icons, sounds and themes\""
CM3="\"Shell and utilities\""

num=0
cp Config.in Config.in.tmp
patch -p0 < Config.in.tmp.patch > /dev/null
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
	comment)
	    case "$tmpmenu1" in
	    "$CM1"|"$CM2"|"$CM3")
		if [ "$num" -ge 1 ]; then
		    eval menustr${num}="$rest"
		fi
	    ;;
	    esac
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

#read file sections - key word to key word
#sed -n '3,5p' file
[ -z "$1" ] && exit 1
setparam=1
while true; do
parm="$1"
if [ "$parm" = "-c" ]; then
    close_end=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-e" ]; then
    exit_nomatch=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-x" ]; then
    longest=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-q" ]; then
    dont_print_file=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-2" ]; then
    find_next_line=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-s" ]; then
    start_line_num=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-1" ]; then
    print_wo_last=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-z" ]; then
    print_till_end=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-i" ]; then
    print_inner=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-n" ]; then
    print_num=1
    shift
    continue
else
    setparam=
fi
if [ -z "$setparam" ]; then
if [ "$parm" != "$(echo "$parm" | sed 's%^-%%')" ]; then
    echo "No such param"
    exit 1
else
    break
fi
fi
done

file=$1
[ ! -f "$file" ] && exit 1
grep1=$2
grep2=$3

if [ ! -z "$start_line_num" ]; then
    if echo "$grep1" | grep -q "[^[:digit:]]"; then
	echo "Parameter not numeric"
	exit 1
    else
	startnum="$grep1"
    fi
fi

if [ ! -z "$start_line_num" ]; then
    NUMS="$startnum"
else
    if [ -z "$longest" ]; then
	NUMS=$(grep -n "$grep1" $file | cut -d : -f 1)
    else
	NUMS=$(grep -n "$grep1" $file | cut -d : -f 1 | head -n 1)
    fi
fi

for i in $NUMS; do
	if [ -z "$longest" ]; then
	    if [ -z "$find_next_line" ]; then
		ENDNUMA=$(tail -n +$i $file | grep -n "$grep2" | cut -d : -f 1 | head -n 1)
	    else
		j=$(expr $i + 1)
		ENDNUMA=$(tail -n +$j $file | grep -n "$grep2" | cut -d : -f 1 | head -n 1)
		[ ! -z "$ENDNUMA" ] && ENDNUMA=$(expr $ENDNUMA + 1)
	    fi
	else
	    if [ -z "$find_next_line" ]; then
		ENDNUMA=$(tail -n +$i $file | grep -n "$grep2" | cut -d : -f 1 | tac | head -n 1)
	    else
		j=$(expr $i + 1)
		ENDNUMA=$(tail -n +$j $file | grep -n "$grep2" | cut -d : -f 1 | tac  | head -n 1)
		[ ! -z "$ENDNUMA" ] && ENDNUMA=$(expr $ENDNUMA + 1)
	    fi
	fi
	#if [ ! -z "$ENDNUMA" ]; then
	#echo "$i - $ENDNUMA - $(expr $i - 1 + $ENDNUMA)"
	#else
	#echo "$i - 1 - $(expr $i - 1 + 1)"
	#fi
	
	if [ -n "$exit_nomatch" ]; then
	    [ -z "$ENDNUMA" ] && continue
	fi
	
	if [ -z "$ENDNUMA" ]; then
	    ENDNUMA=1
	    if [ -z "$dont_print_file" ]; then
		if [ -z "$print_num" ]; then
		    echo "---$file *"
		else
		    echo "---$file:$i *"
		fi
	    fi
	else
	    if [ -z "$dont_print_file" ]; then
		if [ -z "$print_num" ]; then
		    echo "---$file"
		else
		    echo "---$file:$i"
		fi
	    fi
	fi
	#
	if [ "$ENDNUMA" = "1" ]; then
	    if [ -z "$print_till_end" ]; then
		tail -n +$i $file | head -n 1
		#sed -n "${i}p" $file
	    else
		if [ -z "$print_inner" ]; then
		    tail -n +$i $file
		else
		    tail -n +$(expr $i + 1) $file
		fi
	    fi
	else
	    if [ -z "$print_inner" ]; then
		if [ -z "$print_wo_last" ]; then
		    tail -n +$i $file | head -n $ENDNUMA
		else
		    tail -n +$i $file | head -n $(expr $ENDNUMA - 1)
		fi
	    else
		tail -n +$(expr $i + 1) $file | head -n $(expr $ENDNUMA - 2)
	    fi
	fi
done

[ ! -z "$close_end" ] && echo "+++"

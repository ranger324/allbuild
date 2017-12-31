#set -x
#read file sections - key word to key word
#use -- param if -* pattern
#sed -n '3,5p' file
[ -z "$1" ] && exit 1
setparam=1
while true; do
parm="$1"
if [ "$parm" = "-P" ]; then
    [ -z "$grep_param" ] && grep_param="-P" || grep_param="$grep_param -P"
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-I" ]; then
    [ -z "$grep_param" ] && grep_param="-i" || grep_param="$grep_param -i"
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-o" ]; then
    inv_chkpatt=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-d" ]; then
    exclude=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-u" ]; then
    check_pattern=1
    shift
    continue
else
    setparam=
fi
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
#use -- param if -* pattern
if [ "$parm" = "--" ]; then
    shift
    break
fi
if [ -z "$setparam" ]; then
if [ "$parm" != "$(echo "$parm" | sed 's%^-%%')" ]; then
    echo "$0: No such param"
    exit 1
else
    break
fi
fi
done

if [ $exclude ]; then
    excludepatt="$1"
    [ "$excludepatt" != "${excludepatt#-}" ] && excludepatt="\\$excludepatt"
    shift
fi

if [ $check_pattern ]; then
    chkpatt="$1"
    [ "$chkpatt" != "${chkpatt#-}" ] && chkpatt="\\$chkpatt"
    shift
fi

file="$1"
[ ! -f "$file" ] && exit 1

grep1="$2"
[ "$grep1" != "${grep1#-}" ] && grep1="\\$grep1"

grep2="$3"
[ "$grep2" != "${grep2#-}" ] && grep2="\\$grep2"

if [ $start_line_num ]; then
    if echo "$grep1" | grep -q "[^[:digit:]]"; then
	echo "$0: Parameter not numeric"
	exit 1
    else
	startnum="$grep1"
    fi
fi

set -- $grep_param

if [ $start_line_num ]; then
    NUMS="$startnum"
else
    if [ $longest ]; then
	NUMS=$(grep $@ -n "$grep1" "$file" | cut -d : -f 1 | head -n 1)
    else
	NUMS=$(grep $@ -n "$grep1" "$file" | cut -d : -f 1)
    fi
fi

for i in $NUMS; do
	if [ $longest ]; then
	    if [ $find_next_line ]; then
		j=$(expr $i + 1)
		ENDNUMA=$(tail -n +$j "$file" | grep $@ -n "$grep2" | cut -d : -f 1 | tail -n 1)
		[ ! -z "$ENDNUMA" ] && ENDNUMA=$(expr $ENDNUMA + 1)
	    else
		ENDNUMA=$(tail -n +$i "$file" | grep $@ -n "$grep2" | cut -d : -f 1 | tail -n 1)
	    fi
	else
	    if [ $find_next_line ]; then
		j=$(expr $i + 1)
		ENDNUMA=$(tail -n +$j "$file" | grep $@ -n "$grep2" | cut -d : -f 1 | head -n 1)
		[ ! -z "$ENDNUMA" ] && ENDNUMA=$(expr $ENDNUMA + 1)
	    else
		ENDNUMA=$(tail -n +$i "$file" | grep $@ -n "$grep2" | cut -d : -f 1 | head -n 1)
	    fi
	fi
	#if [ ! -z "$ENDNUMA" ]; then
	#echo "$i - $ENDNUMA - $(expr $i - 1 + $ENDNUMA)"
	#else
	#echo "$i - 1 - $(expr $i - 1 + 1)"
	#fi
	
	if [ $exit_nomatch ]; then
	    [ -z "$ENDNUMA" ] && continue
	fi
	
	if [ -z "$ENDNUMA" ]; then
	    ENDNUMA=1
	    if ! [ $dont_print_file ]; then
		if [ $print_num ]; then
		    echo "---$file:$i *"
		else
		    echo "---$file *"
		fi
	    fi
	else
	    if ! [ $dont_print_file ]; then
		if [ $print_num ]; then
		    echo "---$file:$i"
		else
		    echo "---$file"
		fi
	    fi
	fi
	#
	if [ "$ENDNUMA" = "1" ]; then
	    if [ $print_till_end ]; then
		if [ $print_inner ]; then
		    if [ $check_pattern ]; then
			if [ $inv_chkpatt ]; then
			    if ! tail -n +$(expr $i + 1) "$file" | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$(expr $i + 1) "$file" | grep $@ -v "$excludepatt"
				else
				    tail -n +$(expr $i + 1) "$file"
				fi
			    fi
			else
			    if tail -n +$(expr $i + 1) "$file" | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$(expr $i + 1) "$file" | grep $@ -v "$excludepatt"
				else
				    tail -n +$(expr $i + 1) "$file"
				fi
			    fi
			fi
		    else
			if [ $exclude ]; then
			    tail -n +$(expr $i + 1) "$file" | grep $@ -v "$excludepatt"
			else
			    tail -n +$(expr $i + 1) "$file"
			fi
		    fi
		    #tail -n +$(expr $i + 1) "$file"
		else
		    if [ $check_pattern ]; then
			if [ $inv_chkpatt ]; then
			    if ! tail -n +$i "$file" | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$i "$file" | grep $@ -v "$excludepatt"
				else
				    tail -n +$i "$file"
				fi
			    fi
			else
			    if tail -n +$i "$file" | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$i "$file" | grep $@ -v "$excludepatt"
				else
				    tail -n +$i "$file"
				fi
			    fi
			fi
		    else
			if [ $exclude ]; then
			    tail -n +$i "$file" | grep $@ -v "$excludepatt"
			else
			    tail -n +$i "$file"
			fi
		    fi
		    #tail -n +$i "$file"
		fi
	    else
		if [ $check_pattern ]; then
		    if [ $inv_chkpatt ]; then
			if ! tail -n +$i "$file" | head -n 1 | grep $@ -q "$chkpatt"; then
			    if [ $exclude ]; then
				tail -n +$i "$file" | head -n 1 | grep $@ -v "$excludepatt"
			    else
				tail -n +$i "$file" | head -n 1
			    fi
			fi
		    else
			if tail -n +$i "$file" | head -n 1 | grep $@ -q "$chkpatt"; then
			    if [ $exclude ]; then
				tail -n +$i "$file" | head -n 1 | grep $@ -v "$excludepatt"
			    else
				tail -n +$i "$file" | head -n 1
			    fi
			fi
		    fi
		else
		    if [ $exclude ]; then
			tail -n +$i "$file" | head -n 1 | grep $@ -v "$excludepatt"
		    else
			tail -n +$i "$file" | head -n 1
		    fi
		fi
		#tail -n +$i "$file" | head -n 1
		#sed -n "${i}p" "$file"
	    fi
	else
	    if [ $print_inner ]; then
		if [ $check_pattern ]; then
		    if [ $inv_chkpatt ]; then
			if ! tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2) | grep $@ -q "$chkpatt"; then
			    if [ $exclude ]; then
				tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2) | grep $@ -v "$excludepatt"
			    else
				tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2)
			    fi
			fi
		    else
			if tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2) | grep $@ -q "$chkpatt"; then
			    if [ $exclude ]; then
				tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2) | grep $@ -v "$excludepatt"
			    else
				tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2)
			    fi
			fi
		    fi
		else
		    if [ $exclude ]; then
			tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2) | grep $@ -v "$excludepatt"
		    else
			tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2)
		    fi
		fi
		#tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2)
	    else
		if [ $print_wo_last ]; then
		    if [ $check_pattern ]; then
			if [ $inv_chkpatt ]; then
			    if ! tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1) | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1) | grep $@ -v "$excludepatt"
				else
				    tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1)
				fi
			    fi
			else
			    if tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1) | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1) | grep $@ -v "$excludepatt"
				else
				    tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1)
				fi
			    fi
			fi
		    else
			if [ $exclude ]; then
			    tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1) | grep $@ -v "$excludepatt"
			else
			    tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1)
			fi
		    fi
		    #tail -n +$i "$file" | head -n $(expr $ENDNUMA - 1)
		else
		    if [ $check_pattern ]; then
			if [ $inv_chkpatt ]; then
			    if ! tail -n +$i "$file" | head -n $ENDNUMA | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$i "$file" | head -n $ENDNUMA | grep $@ -v "$excludepatt"
				else
				    tail -n +$i "$file" | head -n $ENDNUMA
				fi
			    fi
			else
			    if tail -n +$i "$file" | head -n $ENDNUMA | grep $@ -q "$chkpatt"; then
				if [ $exclude ]; then
				    tail -n +$i "$file" | head -n $ENDNUMA | grep $@ -v "$excludepatt"
				else
				    tail -n +$i "$file" | head -n $ENDNUMA
				fi
			    fi
			fi
		    else
			if [ $exclude ]; then
			    tail -n +$i "$file" | head -n $ENDNUMA | grep $@ -v "$excludepatt"
			else
			    tail -n +$i "$file" | head -n $ENDNUMA
			fi
		    fi
		    #tail -n +$i "$file" | head -n $ENDNUMA
		fi
	    fi
	fi
done

[ $close_end ] && echo "+++"

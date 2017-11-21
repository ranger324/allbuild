#set -x
#stupid param process - use -- param if -* pattern
##sed test param - if not proper not "-*" param (pattern) then echo doesn't work
proclines()
{
#only match pattern inside continue group (main pattern patt1 included in secondary patterns)
#sh _find_format_pattern.sh -c -q "$contpatt" "$patt1" "$patt1" "$patt2" "$patt3"

#sh _find_format_pattern.sh -c -q -a -2 "$contpatt" "$patt1" "$patt2" #patt2 before patt1
#sh _find_format_pattern.sh -c -q -a -1 "$contpatt" "$patt1" "$patt2" #find patt2 where it is after patt1 (def order set)

procend()
{
#numpattern & found (set if needed)
#foundpt (set) [main]
#cont (get)
#disablecont (set if needed)
    if [ "$foundpt" = 1 ]; then
	if [ ! -z "$numpattern" ]; then
	    if [ $invresult ]; then
		foundnum=$(expr $NUM + $NNUM - 1)
		found="$FILE:$foundnum"
	    else
		found="$FILE:$numpattern"
	    fi
	    numpattern=
	    foundpt=
	fi
    fi
    if [ -z "$cont" ]; then
	[ ! -z "$found" ] && echo "$found"
	numpattern=
	foundpt=
	found=
	disablecont=
    fi
}

procend_eq()
{
    if [ "$foundpt" = 1 ]; then
	if [ $invresult ]; then
	    foundnum=$(expr $NUM + $NNUM - 1)
	else
	    [ -z "$foundnum" ] && foundnum=$(expr $NUM + $NNUM - 1)
	fi
	found="$FILE:$foundnum"
	foundpt=
    fi
    if [ -z "$cont" ]; then
	if [ ! -z "$found" ]; then
	    echo "$found"
	    foundnum=
	fi
	foundpt=
	found=
    fi
}

procstart()
{
    if [ $run_through ]; then
	cont=1
    else
	if [ $cp ]; then
	    [ "$line" != "$(echo "$line" | sed "s%$continue_pattern%%")" ] && cont=1 || cont=
	else
	    cont=
	fi
    fi
}

while read -r line; do
case "$line" in
---*:[0-9]*)
    [ "$ocont" = 1 ] && [ ! -z "$found" ] && echo "$found"
    NNUM=0
    FILE=`echo "$line" | sed -e 's%^---%%' -e 's%:.*%%'`
    NUM=`echo "$line" | cut -d : -f 2-`
    numpattern=
    foundnum=
    foundpt=
    found=
    ocont=
    disablecont=
;;
+++)
    [ "$ocont" = 1 ] && [ ! -z "$found" ] && echo "$found"
    numpattern=
    foundnum=
    foundpt=
    found=
    ocont=
    disablecont=
;;
*)
    [ -z "$NNUM" ] && echo "Not formatted input" && exit 1
    NNUM=$(expr $NNUM + 1)

    procstart

    if [ $eqpatt ]; then
	OIFS=$IFS
	IFS=$LFIFS

	if [ $add_match ]; then
	    #not "and" match to "continue" group ("or" add)
	    for pattern in $patterns_linefeed; do
		echo "$line" | grep -q "$pattern" && foundpt=1 && break
	    done
	else
	    #default eq
	    num=0
	    for pattern in $patterns_linefeed; do
		num=$(expr $num + 1)
		if echo "$line" | grep -q "$pattern"; then
		    [ -z "$pattstr" ] && pattstr="#${num}#" || pattstr="${pattstr}#${num}#"
		fi
	    done
	    foundpt_tmp=1
	    for i in $(seq 1 $numpatt); do
		[ "$pattstr" = "${pattstr#*\#$i\#}" ] && foundpt_tmp= && break
	    done
	    [ -z "$cont" ] && pattstr=
	    if [ "$foundpt_tmp" = 1 ]; then
		foundpt=1
		pattstr=
	    fi
	fi

	IFS=$OIFS
	procend_eq
    else
	#main pattern

	if [ $exclude_match ]; then
	    if [ -z "$disablecont" ]; then
		numpattern=$(expr $NUM + $NNUM - 1)
	    else
		#continue when disablecont
		procend
		ocont="$cont"
		continue
	    fi
	else
	    if [ -z "$disablecont" ]; then
		echo "$line" | grep -q "$npattern" && numpattern=$(expr $NUM + $NNUM - 1)
	    else
		#continue when disablecont
		procend
		ocont="$cont"
		continue
	    fi
	fi

	#zero numpattern: numpattern= && found=

	if [ $before_main ]; then
	    if [ ! -z "$numpattern" ]; then
		#only before master patt
		procend
		ocont="$cont"
		continue
	    fi
	fi

	if [ $after_main ]; then
	    if [ -z "$numpattern" ]; then
		#after master patt found and set (+ match even on this line)
		procend
		ocont="$cont"
		continue
	    fi
	fi

	OIFS=$IFS
	IFS=$LFIFS

	if [ $inv_match ]; then
	    if [ $add_match ]; then
		if [ $del_match ]; then
		    #+ "and" match to group if there is only one secondary pattern
		    #from numpattern to match (any) from and to <> : if not after_main
		    #not "and" match to "continue" group ("or" add)
		    #################################################
		    if ! echo "$line" | grep -q "$reset_pattern"; then

			for pattern in $patterns_linefeed; do
			    echo "$line" | grep -q "$pattern" && foundpt=1 && break
			done

		    else
			disablecont=1
			numpattern=
			found=
		    fi
		else
		    #+ "and" match to group if there is only one secondary pattern
		    #from numpattern to match (any) from and to <> : if not after_main
		    #not "and" match to "continue" group ("or" add)
		    #################################################
		    for pattern in $patterns_linefeed; do
			echo "$line" | grep -q "$pattern" && foundpt=1 && break
		    done
		fi
	    else
		if [ $rem_match ]; then
		    if [ $del_match ]; then
			#unmatch
			#from numpattern to unmatch (any) with any in between
			if ! echo "$line" | grep -q "$reset_pattern"; then

			    for pattern in $patterns_linefeed; do
				! echo "$line" | grep -q "$pattern" && foundpt=1 && break
			    done

			else
			    disablecont=1
			    numpattern=
			    found=
			fi
		    else
			#unmatch
			#from numpattern to unmatch (any) with any in between
			for pattern in $patterns_linefeed; do
			    ! echo "$line" | grep -q "$pattern" && foundpt=1 && break
			done
		    fi
		else
		    #find "continue" group without patt (-j nongroup)
		    if [ $exclude_match ]; then
			foundpt_tmp=
			for pattern in $patterns_linefeed; do
			    echo "$line" | grep -q "$pattern" && foundpt_tmp=1 && break
			done
			if [ ! -z "$foundpt_tmp" ]; then
			    disablecont=1
			    numpattern=
			    found=
			else
			    ##also nongroup
			    #foundpt=1 wo if
			    #echo "$line" #groupped output of match
			    if [ $exclude_plus ]; then
				foundpt=1
			    else
				[ ! -z "$cont" ] && foundpt=1
			    fi
			fi
		    else
			#find "continue" group without nonpatt (-j nongroup)
			#implement? all pattern included
			num=0
			found_match=
			found_nomatch=
			for pattern in $patterns_linefeed; do
			    num=$(expr $num + 1)
			    if echo "$line" | grep -q "$pattern"; then
				found_match=1
				[ -z "$pattstr" ] && pattstr="#${num}#" || pattstr="${pattstr}#${num}#"
			    else
				found_nomatch=1
			    fi
			done
			if [ ! -z "$found_match" ]; then
			    if [ $exclude_plus ]; then
				if [ -z "$cont" ]; then
				    [ ! -z "$pattstr" ] && foundpt=1 && pattstr=
				fi
			    else
				if [ ! -z "$cont" ]; then
				    [ ! -z "$pattstr" ] && foundpt=1 && pattstr=
				fi
			    fi
			else
			    #disablecont?
			    #any before main pattern inside group
			    disablecont=1
			    pattstr=
			    numpattern=
			    found=
			fi
		    fi
		fi
	    fi
	else
	    if [ $del_match ]; then
		#default
		if ! echo "$line" | grep -q "$reset_pattern"; then

		    num=0
		    for pattern in $patterns_linefeed; do
			num=$(expr $num + 1)
			if echo "$line" | grep -q "$pattern"; then
			    [ -z "$pattstr" ] && pattstr="#${num}#" || pattstr="${pattstr}#${num}#"
			fi
		    done
		    foundpt_tmp=1
		    for i in $(seq 1 $numpatt); do
			[ "$pattstr" = "${pattstr#*\#$i\#}" ] && foundpt_tmp= && break
		    done
		    [ -z "$cont" ] && pattstr=
		    if [ "$foundpt_tmp" = 1 ]; then
			foundpt=1
			pattstr=
		    fi

		else
		    disablecont=1
		    numpattern=
		    found=
		fi
	    else
		#default
		num=0
		for pattern in $patterns_linefeed; do
		    num=$(expr $num + 1)
		    if echo "$line" | grep -q "$pattern"; then
			[ -z "$pattstr" ] && pattstr="#${num}#" || pattstr="${pattstr}#${num}#"
		    fi
		done
		foundpt_tmp=1
		for i in $(seq 1 $numpatt); do
		    [ "$pattstr" = "${pattstr#*\#$i\#}" ] && foundpt_tmp= && break
		done
		[ -z "$cont" ] && pattstr=
		if [ "$foundpt_tmp" = 1 ]; then
		    foundpt=1
		    pattstr=
		fi
	    fi
	fi

	IFS=$OIFS
	procend
    fi

    ocont="$cont"
;;
esac
done < /dev/stdin
}

#proc params
[ -z "$1" ] && exit 1
setparam=1
while true; do
parm="$1"
if [ "$parm" = "-j" ]; then
    exclude_plus=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-l" ]; then
    exclude_match=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-d" ]; then
    del_match=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-1" ]; then
    after_main=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-2" ]; then
    before_main=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-i" ]; then
    invresult=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-r" ]; then
    rem_match=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-a" ]; then
    add_match=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-q" ]; then
    inv_match=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-e" ]; then
    eqpatt=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-x" ]; then
    run_through=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-f" ]; then
    file_as_param=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-c" ]; then
    continue_pattern=
    cp=1
    shift
    continue
else
    setparam=
fi
#stupid param process
#use -- param if -* pattern
if [ "$parm" = "--" ]; then
    shift
    break
fi
if [ -z "$setparam" ]; then
##sed test param - if not proper not "-*" param (pattern) then echo doesn't work
    if [ "$parm" != "$(echo "$parm" | sed 's%^-%%')" ]; then
	echo "$0: No such param"
	exit 1
    else
	break
    fi
fi
done

LFIFS="
"

#init by params
if [ $file_as_param ]; then
    file="$1"
    shift
    if [ ! -f "$file" ]; then
	echo "$0: File not found"
	exit 1
    fi
    if [ -p /dev/stdin ]; then
	echo "$0: Not reading pipe"
	exit 1
    fi
else
    if [ ! -p /dev/stdin ]; then
	echo "$0: Cannot read pipe"
	exit 1
    else
	pipe=1
    fi
fi

if [ $del_match ]; then
    reset_pattern="$1"
    [ "$reset_pattern" != "${reset_pattern#-}" ] && reset_pattern="\\$reset_pattern"
    shift
fi

if [ $cp ]; then
    continue_pattern="$1"
    [ "$continue_pattern" != "${continue_pattern#-}" ] && continue_pattern="\\$continue_pattern"
    shift
fi

if [ -z "$eqpatt" -a -z "$exclude_match" ]; then
    npattern="$1"
    [ "$npattern" != "${npattern#-}" ] && npattern="\\$npattern"
    shift
fi

numpatt="$#"

OIFS=$IFS
IFS=$LFIFS
patterns_linefeed="$*"
IFS=$OIFS

tmpvar=

OIFS=$IFS
IFS=$LFIFS
for pattern in $patterns_linefeed; do
#bash
#if [ "$pattern" != "${pattern#*\'}" ]; then
if [ "$pattern" != "${pattern#*'}" ]; then
    if [ "$pattern" != "${pattern#-}" ]; then
	[ -z "$tmpvar" ] && tmpvar="\"\\$pattern\"" || tmpvar="$tmpvar \"\\$pattern\""
    else
	[ -z "$tmpvar" ] && tmpvar="\"$pattern\"" || tmpvar="$tmpvar \"$pattern\""
    fi
else
    if [ "$pattern" != "${pattern#-}" ]; then
	[ -z "$tmpvar" ] && tmpvar="'\\$pattern'" || tmpvar="$tmpvar '\\$pattern'"
    else
	[ -z "$tmpvar" ] && tmpvar="'$pattern'" || tmpvar="$tmpvar '$pattern'"
    fi
fi
done
IFS=$OIFS

eval set -- $tmpvar

OIFS=$IFS
IFS=$LFIFS
patterns_linefeed="$*"
IFS=$OIFS


IFS=
cont=
ocont=
numpattern=
foundpt=
found=
disablecont=

if [ $pipe ]; then
    proclines
else
    (echo "---$file:1"; cat "$file"; echo "+++") | proclines
fi

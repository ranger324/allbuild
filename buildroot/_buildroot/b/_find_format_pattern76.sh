#set -x
proclines()
{
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
	IFS=$'\n'

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
	    for ((i=1;i<=numpatt;i++)) do
		[ "$pattstr" = "${pattstr//#$i#/}" ] && foundpt_tmp= && break
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
	if [ -z "$disablecont" ]; then
	    echo "$line" | grep -q "$npattern" && numpattern=$(expr $NUM + $NNUM - 1)
	fi

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
	IFS=$'\n'

	if [ $inv_match ]; then
	    if [ $add_match ]; then
		#+ "and" match to group if there is only one secondary pattern
		#from numpattern to match (any) from and to <> : if not after_main
		#not "and" match to "continue" group ("or" add)
		#################################################
		for pattern in $patterns_linefeed; do
		    echo "$line" | grep -q "$pattern" && foundpt=1 && break
		done
	    else
		if [ $rem_match ]; then
		    #unmatch
		    #from numpattern to unmatch (any) with any in between
		    for pattern in $patterns_linefeed; do
			! echo "$line" | grep -q "$pattern" && foundpt=1 && break
		    done
		else
		    #find cont group without nonpatt
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
			if [ -z "$cont" ]; then
			    [ ! -z "$pattstr" ] && foundpt=1 && pattstr=
			fi
		    else
			disablecont=1
			pattstr=
			numpattern=
			found=
		    fi
		fi
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
	    for ((i=1;i<=numpatt;i++)) do
		[ "$pattstr" = "${pattstr//#$i#/}" ] && foundpt_tmp= && break
	    done
	    [ -z "$cont" ] && pattstr=
	    if [ "$foundpt_tmp" = 1 ]; then
		foundpt=1
		pattstr=
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
if [ -z "$setparam" ]; then
    if [ "$parm" != "$(echo "$parm" | sed 's%^-%%')" ]; then
	echo "No such param"
	exit 1
    else
	break
    fi
fi
done

#init by params
if [ $file_as_param ]; then
    file="$1"
    shift
    if [ ! -f "$file" ]; then
	echo "File not found"
	exit 1
    fi
    if [ -p /dev/stdin ]; then
	echo "Not reading pipe"
	exit 1
    fi
else
    if [ ! -p /dev/stdin ]; then
	echo "Cannot read pipe"
	exit 1
    else
	pipe=1
    fi
fi

if [ $cp ]; then
    continue_pattern="$1"
    shift
fi

if ! [ $eqpatt ]; then
    npattern="$1"
    shift
fi

numpatt="$#"

OIFS=$IFS
IFS=$'\n'
patterns_linefeed="$*"
IFS=$OIFS

IFS=
cont=
ocont=
found=
numpattern=
foundpt=

if [ $pipe ]; then
    proclines
else
    (echo "---$file:1"; cat "$file"; echo "+++") | proclines
fi

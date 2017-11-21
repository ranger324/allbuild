#set -x
proclines()
{
while read -r line; do
case "$line" in
---*:[0-9]*)
    [ "$ocont" = 1 ] && [ ! -z "$found" ] && echo "$found"
    NNUM=0
    FILE=`echo "$line" | sed -e 's%^---%%' -e 's%:.*%%'`
    NUM=`echo "$line" | cut -d : -f 2-`
    numpattern=
    foundpt=
    found=
    ocont=
;;
+++)
    [ "$ocont" = 1 ] && [ ! -z "$found" ] && echo "$found"
    numpattern=
    foundpt=
    found=
    ocont=
;;
*)
    [ -z "$NNUM" ] && echo "Not formatted input" && exit 1
    NNUM=$(expr $NNUM + 1)

    if [ $cp ]; then
	[ "$line" != "$(echo "$line" | sed "s%$continue_pattern%%")" ] && cont=1 || cont=
    else
	cont=
    fi


    echo "$line" | grep -q "$npattern" && numpattern=$(expr $NUM + $NNUM - 1)
    OIFS=$IFS
    IFS=$'\n'

    if [ $inv_match ]; then
	if [ $add_match ]; then
	    #add_match
	    #any match set (add) and break
	    for pattern in $patterns_linefeed; do
		echo "$line" | grep -q "$pattern" && foundpt=1 && break
	    done
	else
	    #del_match
	    #any nomatch set (remove) and break
	    for pattern in $patterns_linefeed; do
		! echo "$line" | grep -q "$pattern" && foundpt= && break
	    done
	fi
    else
	num=0
	for pattern in $patterns_linefeed; do
	    num=$(expr $num + 1)
	    if echo "$line" | grep -q "$pattern"; then
		[ -z "$pattstr" ] && pattstr="#${num}#" || pattstr="${pattstr}#${num}#"
	    fi
	done
	foundpt=1
	for i in $(seq 1 $numpatt); do
	    [ "$pattstr" = "${pattstr//#$i#/}" ] && foundpt= && break
	done
	if [ "$foundpt" = 1 ]; then
	    pattstr=
	fi
    fi

    IFS=$OIFS

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
	pattstr=
	foundpt=
	found=
    fi

    ocont="$cont"
;;
esac
done < /dev/stdin
}

[ -z "$1" ] && exit 1
setparam=1
while true; do
parm="$1"
if [ "$parm" = "-i" ]; then
    invresult=1
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

npattern="$1"
shift

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

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
    num=0
;;
+++)
    [ "$ocont" = 1 ] && [ ! -z "$found" ] && echo "$found"
    numpattern=
    foundpt=
    found=
    ocont=
    num=0
;;
*)
    [ -z "$NNUM" ] && echo "Not formatted input" && exit 1
    NNUM=$(expr $NNUM + 1)

    if [ $run_through ]; then
	cont=1
    else
	if [ $cp ]; then
	    [ "$line" != "$(echo "$line" | sed "s%$continue_pattern%%")" ] && cont=1 || cont=
	else
	    cont=
	fi
    fi

    if [ $eqpatt ]; then
	OIFS=$IFS
	IFS=$'\n'
	for pattern in $patterns_linefeed; do
	    if echo "$line" | grep -q "$pattern"; then
		if [ $invresult ]; then
		    [ -z "$foundpt" ] && foundpt=$(expr $NUM + $NNUM - 1)
		else
		    foundpt=$(expr $NUM + $NNUM - 1)
		fi
		num=$(expr $num + 1)
	    fi
	done
	IFS=$OIFS

	if [ "$num" = "$numpatt" ]; then
	    found="$FILE:$foundpt"
	    num=0
	fi

	if [ -z "$cont" ]; then
	    [ ! -z "$found" ] && echo "$found"
	    num=0
	    foundpt=
	    found=
	fi
    else
	echo "$line" | grep -q "$npattern" && numpattern=$(expr $NUM + $NNUM - 1)
	OIFS=$IFS
	IFS=$'\n'
	foundpt=1
	for pattern in $patterns_linefeed; do
	    if [ $invresult ]; then
		if ! echo "$line" | grep -q "$pattern"; then
		    foundpt=
		else
		    foundnum=$(expr $NUM + $NNUM - 1)
		fi
	    else
		! echo "$line" | grep -q "$pattern" && foundpt=
	    fi
	done
	IFS=$OIFS

	if [ "$foundpt" = 1 ]; then
	    if [ ! -z "$numpattern" ]; then
		if [ $invresult ]; then
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
	fi
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

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
    foundpt=1
    for pattern in $patterns_linefeed; do
	! echo "$line" | grep -q "$pattern" && foundpt=
    done
    IFS=$OIFS

    if [ "$foundpt" = 1 ]; then
	if [ ! -z "$numpattern" ]; then
	    found="$FILE:$numpattern"
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

    ocont="$cont"
;;
esac
done < /dev/stdin
}

[ -z "$1" ] && exit 1
setparam=1
while true; do
parm="$1"
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

#patterns="$@"
#lastpatt2="$@"
#for lastpatt2; do true; done
#while read line; do echo $line; done < "${1:-/dev/stdin}"

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

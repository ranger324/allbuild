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

file="$1"
[ ! -f "$file" ] && exit 1

grep1="$2"
[ "$grep1" != "${grep1#-}" ] && grep1="\\$grep1"

grep2="$3"
[ "$grep2" != "${grep2#-}" ] && grep2="\\$grep2"

set -- $grep_param

TMP1="$grep2"
grep2="$grep1"
grep1="$TMP1"

NUMS1=$(grep $@ -n "$grep1" "$file" | cut -d : -f 1)
NUMS2=$(grep $@ -n "$grep2" "$file" | cut -d : -f 1)

for i in $NUMS1; do
    ENDNUMA=
    for j in $NUMS2; do
	if [ "$j" -lt "$i" ]; then
	    OLD_NUM="$j"
	    continue
	else
	    ENDNUMA="$OLD_NUM"
	    break
	fi
    done
    [ -z "$ENDNUMA" ] && ENDNUMA="$OLD_NUM"
    [ ! -z "$ENDNUMA" ] && sed -n "$ENDNUMA,${i}p" "$file"
done

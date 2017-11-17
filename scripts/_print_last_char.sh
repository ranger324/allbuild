[ -z "$1" ] && exit 1
FILE="$1"
[ ! -f "$FILE" ] && exit 2

SIZE=`stat -c '%s' "$FILE"`
retval=$?
[ "$retval" != 0 ] && exit $retval

[ "$SIZE" -lt 1 ] && exit 0

FEND=`od -v -A n -t x1 -N 1 -j $(expr $SIZE - 1) "$FILE"`
retval=$?
[ "$retval" != 0 ] && exit $retval

echo $FEND

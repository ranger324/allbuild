[ -z "$1" ] && exit 1
FILE="$1"

while true; do
SIZE=`stat -c %s "$FILE"`
[ "$SIZE" -lt 1 ] && exit 2
hex_end=`od -v -A n -t x1 -N 2 -j $(expr $SIZE - 2) "$FILE"`
[ "$hex_end" = " 0a 0a" ] && truncate -s $(expr $SIZE - 1) "$FILE" || break
done

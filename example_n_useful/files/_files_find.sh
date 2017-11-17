locate -A "" | while read file; do
SIZE=`stat -c %s $file 2> /dev/null`
[ ! -z "$SIZE" ] && echo "$SIZE $file"
done

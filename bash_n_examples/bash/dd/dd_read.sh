(echo -n "asd"; echo -n "#") | \
while A=`dd of=/dev/stdout bs=1 count=1 2> /dev/null`; do
#while A=`dd of=/dev/stdout bs=1 count=1 status=none 2> /dev/null`; do
[ "$A" = "#" ] && break
echo -n "$A"
done
echo

IFS=$'#'
A="123"
A=`echo "$A" | sed 's/./&#/g'`
echo "$A"
for i in $A; do
    echo "$i"
done

i=0
while true; do
    i=$(expr $i + 1)
    echo "$i"
    [ "$i" = 10 ] && break
done
echo "#0"
for i in $(seq 1 10); do
echo "$i"
done
echo "#1"
var="$@"
for var; do
echo "$var"
done
echo "#2"
var=1

for i in $var; do
echo "$i"
done

echo "#3"
for var; do
echo "*$var*"
done

set -- a 'b c'
var="$@"
for var; do
echo "$var"
done

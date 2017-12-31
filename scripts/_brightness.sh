[ -z "$1" ] && BR=2 || BR=$1

LSBRF=`find /sys -type f -name "brightness" -path "*video*"`
[ -z "$LSBRF" ] && exit 0
OIFS=$IFS
IFS=$'\n'
for file in $LSBRF; do
    echo $BR > $file
done
IFS=$OIFS

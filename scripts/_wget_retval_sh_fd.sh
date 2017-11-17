
exec 4>&1
WGET_CONNOPTS="--passive-ftp -t 1 --timeout=5"
WGET_OPTS="-q --progress=dot --show-progress"

[ -z "$1" ] && exit 1
URL="$1"
FILE="${URL##*/}"

bar=`expr $(stty size | cut -d " " -f 2) - ${#FILE} - 1 - 2 - 4 - 1 - 1`

retval=`(((wget $WGET_OPTS $WGET_CONNOPTS $URL -O $FILE 2>&1; printf "$?" >&3) | \
sed -u -n -e 's/%.*//' -e 's/.* //p' | \
while read perc; do
if [ "$dperc" != "$perc" ] && [ ! -z "$perc" ]; then
    barp=$(($bar * $perc / 100))
    barend=$(($bar - $barp))
    printf "\r%-$((${#FILE} + 1))s" "$FILE"
    printf "["
    for i in $(seq 1 $barp); do
	printf "#"
    done
    for i in $(seq 1 $barend); do
	printf " "
    done
    printf "] "
    printf "%4s" "${perc}%"
    dperc=$perc
fi
done) >&4) 3>&1`

if [ "$retval" = "0" ]; then
    printf "\r%-$((${#FILE} + 1))s" "$FILE"
    printf "["
    for i in $(seq 1 $bar); do
	printf "#"
    done
    printf "] "
    printf "%4s" "100%"
    printf "\n"
fi

exit $retval

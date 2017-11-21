
#wget -q --progress=dot --show-progress https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.11.3.tar.xz 2>&1 | \
# stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { match($0, / ([0-9][0-9]?[0-9]?)%/, arr); print arr[1] }'

#wget -q --progress=dot --show-progress https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.11.3.tar.xz 2>&1 | \
# stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { match($0, / ([0-9][0-9]?[0-9]?)%/, arr); print arr[1] }' | \
# dialog --gauge "Download Test" 10 100

#wget -q --progress=bar --show-progress https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.11.3.tar.xz

##### --passive-ftp -nd -t 1 --timeout=5
WGET_OPTS="-q --progress=dot --show-progress"
FILE=linux-4.11.3.tar.xz
URL=https://www.kernel.org/pub/linux/kernel/v4.x/$FILE
#FILE=intltool-0.51.0.tar.gz
#URL=http://launchpad.net/intltool/trunk/0.51.0/+download/$FILE

bar=`expr $(stty size | cut -d " " -f 2) - ${#FILE} - 1 - 2 - 4 - 1 - 1`

wget $WGET_OPTS $URL 2>&1 | \
sed -u -n -e 's/%.*//' -e 's/.* //p' | \
while read perc; do
if [ "$dperc" != "$perc" ]; then
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
done
retval=${PIPESTATUS[0]}
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

#https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.9.tar.xz
#[[ "${PIPESTATUS[@]}" =~ [^0\ ] ]]

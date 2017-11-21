
[ -z "$1" ] && exit 1
URL="$1"
echo -ne "$URL "

time1=`date +%s.%N`
time1_sec=${time1%.*}
time1_nanosec=${time1#*.}

timeout 10 wget -q -o /dev/null -O - $URL > /tmp/file 2> /dev/null

time2=`date +%s.%N`
time2_sec=${time2%.*}
time2_nanosec=${time2#*.}


sec=$((time2_sec - time1_sec))

time1_hund=`echo $time1_nanosec | head -c 2 | sed 's/^0\+//'`
time2_hund=`echo $time2_nanosec | head -c 2 | sed 's/^0\+//'`

[ -z "$time1_hund" ] && time1_hund=0
[ -z "$time2_hund" ] && time2_hund=0

hund1=$((100 - $time1_hund))
hund2=$time2_hund

if [ "$((hund1 + hund2))" -ge 100 ]; then
    sec=$((sec + 1))
    hund=$((hund1 + hund2 - 100))
else
    hund=$((hund1 + hund2))
fi

[ `echo -n "$hund" | wc -c` = 1 ] && \
    time="${sec}0${hund}" || time="${sec}${hund}"

#[ `echo -n "$hund" | wc -c` = 1 ] && \
#    time="${sec}.0${hund}" || time="${sec}.${hund}"

speed=$(($(stat -c %s /tmp/file) * 100 / $time))
echo $speed

#date +%s%N


[ -z "$1" ] && exit 1
URL="$1"
echo -ne "$URL "

time1=`date +%s.%N`

timeout --foreground 10 wget -q -o /dev/null -O - $URL > /tmp/file 2> /dev/null

time2=`date +%s.%N`

time1_sec=${time1%.*}
numchar=${#time1_sec}

time1_cont=${time1/./}
time1_hund=${time1_cont:0:$numchar+2}
time2_cont=${time2/./}
time2_hund=${time2_cont:0:$numchar+2}

hund=$((time2_hund - time1_hund))
[ "$hund" = 0 ] && echo 0 && exit 1
speed=$(($(stat -c %s /tmp/file) * 100 / $hund))
echo $speed

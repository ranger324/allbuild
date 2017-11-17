find /sys/devices -name modalias | \
while read line; do
    modprobe -R "$(cat "$line")" 2> /dev/null
done | \
sort -u | \
while read l2; do
    echo "****$l2****"
    modinfo "$l2"
    echo
done

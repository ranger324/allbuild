ls /dev/sd[a-z][1-9]* | \
while read line; do
    grep -q "^$line " /proc/mounts || udisksctl mount -b $line
done

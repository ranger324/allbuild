ls /dev/sd[a-z][1-9]* | \
while read line; do
    grep -q "^$line " /proc/mounts || udisks --mount $line
done

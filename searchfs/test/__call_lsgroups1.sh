export LC_COLLATE=C
A=$(sh _find_group_defs.sh "*" | tr -d '\n' | sed -e 's/@@/@/g' -e 's/^@//')
IFS=$'@'
echo "$A" | \
while read -r -d '@' val; do
    echo $val
done | sort -u

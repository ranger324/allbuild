find -mindepth 2 -type f -name "*.mk" | \
while read file; do
    grep -o '^[A-Z0-9a-z_$()-]\+[[:space:]]\+[+?-]*=' "$file" | grep '[$()]\+[[:space:]]\+[+?-]*='
done

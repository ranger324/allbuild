printfile=1
[ "$1" = "-n" ] && printfile=
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read file; do
    grep -Hn "^PACKAGES_PERMISSIONS_TABLE[[:space:]]\+[+=:-]\+" "$file"
done

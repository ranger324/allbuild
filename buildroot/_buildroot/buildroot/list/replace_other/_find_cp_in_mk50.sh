#backslash group print (one line w question) (lines with \ at end of line)
sh _find_format_pattern%0.sh > /tmp/file
exec 3< /tmp/file
while read -r -u 3 line; do
    FILE=`echo "$line" | cut -d : -f 1`
    NUM=`echo "$line" | cut -d : -f 2`
    ONUM="$NUM"
    LINES=`wc -l "$FILE" | cut -d ' ' -f 1`
    echo "**$FILE:$NUM"
    read -r -s -N 1 -p "Show line? (y/n):" showline
    echo
    if [ "$showline" = "y" ]; then
	sed -n "${NUM}p" "$FILE"
    fi
done

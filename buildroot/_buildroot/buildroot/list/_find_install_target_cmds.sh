
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read -r mkfile; do
    grep -Hn "^define[[:space:]]\+.*_INSTALL_TARGET_CMDS" "$mkfile"
done | \
while read -r line; do
    NNUM=0
    FILE=`echo "$line" | cut -d : -f 1`
    NUM=`echo "$line" | cut -d : -f 2`
    #LINEE=`echo "$line" | cut -d : -f 3-`
    #[ "$OFILE" != "$FILE" ] && echo "---$FILE" && OFILE="$FILE"

    #sh _find_file_section.sh -s -q "$FILE" "$NUM" "^endef"
    sh _find_file_section.sh -s "$FILE" "$NUM" "^endef"
done

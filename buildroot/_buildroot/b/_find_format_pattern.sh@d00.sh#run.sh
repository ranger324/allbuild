#contpatt="[\]$"
find -mindepth 2 -type f -name "*.mk" | \
while read file; do
    dash _find_file_section.sh -c -n -e -x "$file" "^define" "^endef"
#done | dash _find_format_pattern.sh@d00.sh -x "echo" "sed"
done | dash _find_format_pattern.sh@d00.sh -c "[\]$" "b" "c"

#contpatt="[\]$"

# eg.: no other than patterns inside continue pattern line by line (in makefile backslash+linefeed separated "one line command")
# main pattern included in sec patterns
find -type f -name "*.mk" | \
while read file; do
    sh /bin/_find_file_section.sh -c -n -e -x "$file" "^define" "^endef"
#[[:space:]]\+rm[[:space:]]\+-[rf]\+\|[[:space:]]\+\$(RM)[[:space:]]\+\|[[:space:]]\+rm[[:space:]]\+
done | sh /bin/_find_format_pattern.sh -c -q "[\]$" "[[:space:]]\+rm[[:space:]]\+-[rf]\+" "[[:space:]]\+rm[[:space:]]\+-[rf]\+" "[[:space:]]\+\$(RM)[[:space:]]\+" "[[:space:]]\+rm[[:space:]]\+" "\$(TARGET_DIR)"

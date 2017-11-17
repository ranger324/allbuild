#contpatt="[\]$"
find /bin -type f -name "*.sh" | \
while read file; do
    sh /bin/_find_file_section.sh -c -n -e -x "$file" "^[[:space:]]*if" "^[[:space:]]*fi"
done | sh /bin/_find_format_pattern.sh -x "echo" "sed"

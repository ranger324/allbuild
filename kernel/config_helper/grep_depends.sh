#grep depends sections in kconfigs
find -type f -name "Kconfig" | \
while read line; do
    sh /bin/_find_file_section.sh -n "$line" "^[[:space:]]\+depends[[:space:]]\+on[[:space:]]\+" "[^\]$"
done

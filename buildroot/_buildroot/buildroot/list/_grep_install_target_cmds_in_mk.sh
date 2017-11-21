find -mindepth 2 -type f -name "*.mk" | \
while read line; do
    sh /bin/_find_file_section.sh -n "$line" "^define[[:space:]]\+.*_INSTALL_TARGET_CMDS" "^endef"
done

find -mindepth 2 -type f -name "*.mk" | \
while read line; do
    sh /bin/_find_file_section.sh -n -e -x $line "cp[[:space:]]\+-[adpfr]\+" "\$(TARGET_DIR)"
done

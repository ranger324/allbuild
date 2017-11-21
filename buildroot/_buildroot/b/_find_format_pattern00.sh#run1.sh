contpatt="[\]$"
(find -mindepth 2 -type f -name "*.mk" | \
while read line; do
    sh _find_file_section.sh -n -e -x "$line" "\$(STAGING_DIR)\|\$(TARGET_DIR)" "\$(STAGING_DIR)\|\$(TARGET_DIR)"
done; echo "+++") | sh _find_format_pattern.sh -c "$contpatt" "\$(STAGING_DIR)" "\$(TARGET_DIR)"

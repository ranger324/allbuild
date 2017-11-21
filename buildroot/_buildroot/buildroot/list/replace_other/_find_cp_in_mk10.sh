find -mindepth 2 -type f -name "*.mk" | \
while read line; do
    grep -Hn "\$(STAGING_DIR)\|\$(TARGET_DIR)" $line
done

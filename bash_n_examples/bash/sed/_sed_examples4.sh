find -mindepth 2 -type f -name "*.mk" | \
while read line; do
grep -oH '\$(STAGING_DIR)\$(TARGET_DIR)' $line
done

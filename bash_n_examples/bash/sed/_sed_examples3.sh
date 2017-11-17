find -mindepth 2 -type f -name "*.mk" | \
while read line; do
sed -i 's/\$(STAGING_DIR)\$(TARGET_DIR)/\$(TARGET_DIR)/g' $line
done

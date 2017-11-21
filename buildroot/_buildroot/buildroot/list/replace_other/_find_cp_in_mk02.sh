#find -mindepth 2 -type f -name "*.mk" | \
#while read line; do
#    sh /bin/_find_file_section.sh -n -e -x $line "\$(STAGING_DIR)" "\$(TARGET_DIR)"
#    sh /bin/_find_file_section.sh -n -e -x $line "\$(TARGET_DIR)" "\$(STAGING_DIR)"
#done

find -mindepth 2 -type f -name "*.mk" | \
while read line; do
    sh /bin/_find_file_section.sh -n -e -x $line "\$(STAGING_DIR)\|\$(TARGET_DIR)" "\$(STAGING_DIR)\|\$(TARGET_DIR)"
done

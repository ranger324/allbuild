find -mindepth 2 -type f -name "*.mk" | xargs grep "cp.*-[adpfr].*\$(STAGING_DIR).*\$(TARGET_DIR)"

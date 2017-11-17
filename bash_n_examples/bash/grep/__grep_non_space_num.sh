find -type f -name "*.mk" | xargs -r grep -h "^[[:space:]]\+\$([^ ]\+)" | grep "^[[:space:]]\+\$([^)]*[0-9][^)]*)"

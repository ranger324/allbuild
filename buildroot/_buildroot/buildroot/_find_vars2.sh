find -mindepth 2 -type f -name "*.mk" | xargs -r grep '^[A-Z0-9a-z_$()-]\+[[:space:]]\+[+?-]*='

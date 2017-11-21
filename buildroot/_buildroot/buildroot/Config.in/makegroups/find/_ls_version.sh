find -mindepth 2 -name "*.mk" | xargs grep "_VERSION[[:space:]]\+=" | cut -d : -f 1 | sort -u

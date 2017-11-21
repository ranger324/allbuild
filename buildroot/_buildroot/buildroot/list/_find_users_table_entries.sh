find -mindepth 2 -type f -name "*.mk" | xargs -r -i sh _find_file_section.sh {} "^define[[:space:]]\+.*_USERS" "^endef"

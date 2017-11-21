export LC_COLLATE=C
find -mindepth 1 \( -type d -printf "%P/\n" \) -o \( -type f -printf "%P\n" \) -o \( -type l -printf "%P\n" \) | sort -t /
#grep -vxf grep file already exists in other package - collision
# check file overwrite

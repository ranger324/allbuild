
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read -r mkfile; do
#install -> host_install_cmds
    grep -Hn "^define[[:space:]]\+.*_INSTALL_CMDS" "$mkfile"
done

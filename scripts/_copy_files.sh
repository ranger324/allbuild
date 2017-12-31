[ -z "$1" ] && exit 1
find -type l -printf "%P\n" -o -type f -printf "%P\n" | \
    grep -v "\.tar\.gz$\|\.tar\.xz$\|\.tar\.lz$\|\.tar\.bz2$\|\.tgz$\|\.tbz2$\|\.tbz$" | \
    xargs -r -i sh -c "cp -dp --parents {} $1"

if [ ! -z "$1" ]; then
    if [ ! -d "$1" ]; then
        echo "Directory not found: $1"
        exit 1
    fi
    DIR="$1"
    cd "$DIR"
fi

find -type l -printf "%P\n" | while read link; do [ -d "$link" ] && echo "$link"; done

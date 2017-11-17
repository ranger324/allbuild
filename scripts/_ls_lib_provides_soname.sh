if [ ! -z "$1" ]; then
    DIR="$1"
    [ ! -d "$DIR" ] && echo "No such directory" && exit 1
    cd "$DIR"
fi
_findbin | xargs -r -i sh -c 'SONAME=$(readelf -d {} | grep " 0x[0-9a-f]\+ (SONAME)" | grep -o "\[.*\]"); [ ! -z "$SONAME" ] && echo "{} $SONAME"'

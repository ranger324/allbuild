
if [ ! -z "$1" ]; then
    DIR="$1"
    [ ! -d "$DIR" ] && echo "No such directory" && exit 1
    cd "$DIR"
fi
_findbin | xargs -r -i sh -c 'readelf -d {} | grep -q " 0x[0-9a-f]\+ (SONAME)" && echo "{}"'

##$1 -a
#find -type f -name "*.so*" | while read line; do echo $line; nm $1 $line 2>/dev/null| grep "dlclose.*2\.2\.5"; done
#[TUbd]

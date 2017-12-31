if [ ! -z "$1" ]; then
    DIR="$1"
    [ ! -d "$DIR" ] && echo "No such directory" && exit 1
    cd "$DIR"
fi
_findbin | xargs -r -i sh -c 'echo "./{}"; readelf -d {}; echo'

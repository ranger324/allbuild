if [ ! -z "$1" ]; then
    DIR=$1
    [ ! -d "$DIR" ] && echo "No such directory" && exit 1
    cd $DIR
fi
_findbin | xargs -r -i sh -c "readelf -h {} | grep -q '^[[:space:]]\+Type:[[:space:]]\+EXEC' && echo {}"

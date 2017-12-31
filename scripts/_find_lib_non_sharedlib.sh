
if [ "$1" = "-l" ]; then
    findlinks=1
    shift
fi

if [ ! -z "$1" ]; then
    DIR=$1
    [ ! -d "$DIR" ] && echo "No such directory" && exit 1
    cd $DIR
fi

if [ $findlinks ]; then
    _findbin -l | xargs -r -i sh -c "readelf -h {} | grep -q '^[[:space:]]\+Type:[[:space:]]\+EXEC' && echo {}"
else
    _findbin | xargs -r -i sh -c "readelf -h {} | grep -q '^[[:space:]]\+Type:[[:space:]]\+EXEC' && echo {}"
fi

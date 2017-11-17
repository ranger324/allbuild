if [ ! -z "$1" ]; then
    DIR=$1
    [ ! -d "$DIR" ] && echo "No such directory" && exit 1
    cd $DIR
fi
find -mindepth 1 -maxdepth 1 -type d | sort -V | xargs -r -i sh -c "echo -ne '{} '; du -sh {} | cut -d $'\t' -f 1"

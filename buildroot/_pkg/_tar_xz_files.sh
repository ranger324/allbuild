#tar xz targzs to destination
DIR="$1"
DIR2="$2"

[ ! -d "$DIR" ] && echo "No such source directory" && exit 1
[ ! -d "$DIR2" ] && echo "No such destination directory" && exit 1

DIR2=`cd "$DIR2" && pwd -P`
[ "$?" != 0 ] && echo "Cannot change to destination directory" && exit 1

cd "$DIR"
[ "$?" != 0 ] && echo "Cannot change to source directory" && exit 1

ls *.tar.gz 2> /dev/null | xargs -r -i tar xzf {} -C "$DIR2"

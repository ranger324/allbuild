#tar xz targzs to destination
DIR="$1"
DIR2="$2"

[ ! -d "$DIR" ] && echo "No such source directory" && exit 1
[ ! -d "$DIR2" ] && echo "No such destination directory" && exit 1

DIR2=`cd "$DIR2" && pwd -P`
[ "$?" != 0 ] && echo "Cannot change to destination directory" && exit 1

cd "$DIR"
[ "$?" != 0 ] && echo "Cannot change to source directory" && exit 1

ls *.tar.gz 2> /dev/null | \
while read targz_file; do
    tar xzf "$targz_file" -C "$DIR2" 2> /dev/null
    retval=$?
    #2 return code (value) (error) eg.: overwriting an existing directory with symbolic link
    if [ "$retval" = 2 ]; then
	tar tzf "$targz_file" | grep -v "/$" | \
	while read file; do
	    #[ -d "$DIR2"/"$file" -a ! -L "$DIR2"/"$file" ] && echo "$file"
	    [ -d "$DIR2"/"$file" -a ! -L "$DIR2"/"$file" ] && rm -rf "$DIR2"/"$file"
	done
	tar xzf "$targz_file" -C "$DIR2" 2> /dev/null
    fi
done

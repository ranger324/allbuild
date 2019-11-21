#tar xz targzs to destination

untargz()
{
while read targz_file; do
    tar xzf "$targz_file" -C "$DIR_DST" 2> /dev/null
    retval=$?
    #2 return code (value) (error) eg.: overwriting an existing directory with symbolic link
    if [ "$retval" = 2 ]; then
	tar tzf "$targz_file" | grep -v "/$" | \
	while read file; do
	    #[ -d "$DIR_DST"/"$file" -a ! -L "$DIR_DST"/"$file" ] && echo "$file"
	    [ -d "$DIR_DST"/"$file" -a ! -L "$DIR_DST"/"$file" ] && rm -rf "$DIR_DST"/"$file"
	done
	tar xzf "$targz_file" -C "$DIR_DST" 2> /dev/null
    fi
done < /dev/stdin
}

if [ "$#" = 3 ]; then
    TGZ="$1"
    [ ! -f "$TGZ" ] && echo "No such targz file" && exit 1
    shift
fi

DIR_SRC="$1"
DIR_DST="$2"

[ ! -d "$DIR_SRC" ] && echo "No such source directory" && exit 1
[ ! -d "$DIR_DST" ] && echo "No such destination directory" && exit 1

DIR_DST=`cd "$DIR_DST" && pwd -P`
[ "$?" != 0 ] && echo "Cannot change to destination directory" && exit 1

cd "$DIR_SRC"
[ "$?" != 0 ] && echo "Cannot change to source directory" && exit 1

if [ -n "$TGZ" ]; then
    echo "$TGZ" | untargz
else
    ls *.tar.gz 2> /dev/null | untargz
fi

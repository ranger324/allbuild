#tar xz targzs to destination

chk_exist()
{
#check if files exist on destination except symlinks to directories
tar tzf "$targz_file" | grep -v "/$" | \
while read line; do
    [ -e "$DIR_DST"/"$line" ] && echo "$line"
done | grep -vFx "$(cat "$DIR_DST"/var/lib/instpkg/local/*/dirlinks 2> /dev/null)"
}

untargz()
{
while read targz_file; do
    #check if files exist
    if [ $chk_dirlinks ]; then
	LS_EXIST=`chk_exist`
	[ ! -z "$LS_EXIST" ] && echo "$LS_EXIST" | sed "s%.*%$targz_file : '&' exists on destination path%" && exit 1
    fi
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

[ "$1" = "-c" ] && chk_dirlinks=1 && shift

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

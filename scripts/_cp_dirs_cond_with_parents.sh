#copy directories with parent directories which contains specified file (only 'find -name' (also dirs))
#param: [-d] "*filename*" "dir"
[ -z "$2" ] && echo -ne "Specify files and destination directory\nparam: '*filename*' 'dir'\n" && exit 1
[ "$1" = "-d" ] && delfiles=1 && shift

if [ $delfiles ]; then
    xargscmd="DIR=\$(dirname {}); cp -Rdp --parent \$DIR $2; rm -rf \$DIR"
    find -name "$1" | xargs -r -i sh -c "$xargscmd"
else
    xargscmd="DIR=\$(dirname {}); cp -Rdp --parent \$DIR $2"
    find -name "$1" | xargs -r -i sh -c "$xargscmd"
fi

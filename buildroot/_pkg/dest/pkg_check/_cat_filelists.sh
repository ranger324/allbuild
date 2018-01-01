nofiles()
{
    echo "no files"
    exit 1
}

[ -z "$1" ] && cd /dest || cd "$1"
ls *.files > /dev/null 2>&1 || nofiles
echo -n > /_filelist.dat
ls *.files | sed -e "s%\.tar\.gz\.files$%%" -e 's%\(.*\)-\([^-]\+\)$%\2 \1%' -e 's%\(.*\)-\([^-]\+\)$%\2 \1%' | \
while read VER REV NAME; do
    echo "%%$NAME $VER $REV $NAME-$VER-$REV.tar.gz%%" >> /_filelist.dat
    cat $NAME-$VER-$REV.tar.gz.files >> /_filelist.dat
done

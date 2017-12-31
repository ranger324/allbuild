#version numeric?
nofiles()
{
    echo "no files"
    exit 1
}

[ -z "$1" ] && cd /dest || cd "$1"
ls *.tar.gz > /dev/null 2>&1 || nofiles
ls *.tar.gz | sed -e "s%\.tar\.gz$%%" -e 's%\(.*\)-\([^-]\+\)$%\2 \1%' -e 's%\(.*\)-\([^-]\+\)$%\2 \1%' | \
while read VER REV NAME; do
    VER=`echo "$VER" | tr '.' '0'`
    if echo "$VER" | grep -q "[^[:digit:]]"; then
	echo "$NAME $VER $REV"
    fi
done

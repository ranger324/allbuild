#is there more version of a package
nofiles()
{
    echo "no files"
    exit 1
}

[ -z "$1" ] && cd /dest || cd "$1"
ls *.tar.gz > /dev/null 2>&1 || nofiles
ls *.tar.gz | rev | cut -d - -f 3- | rev | sort | tee /_a | sort -u > /_b
comm -23 /_a /_b

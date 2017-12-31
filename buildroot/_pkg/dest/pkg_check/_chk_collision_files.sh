#find files existing in other packages
nofiles()
{
    echo "no files"
    exit 1
}

[ -z "$1" ] && cd /dest || cd "$1"
ls *.files > /dev/null 2>&1 || nofiles
grep -v "/$" *.files > /_aa
cut -d : -f 2- /_aa | sort | tee /_bb | sort -u > /_cc
comm -23 /_bb /_cc | sort -u | \
while read file; do
    grep ".*:$file$" /_aa
done
##grep -f

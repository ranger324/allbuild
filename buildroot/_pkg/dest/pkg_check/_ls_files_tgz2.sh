#create filelist from targzs
nofiles()
{
    echo "no files"
    exit 1
}

[ -z "$1" ] && cd /dest || cd "$1"
rm -f *.files
ls *.tar.gz > /dev/null 2>&1 || nofiles
# sort LC_COLLATE=C
for i in *.tar.gz; do echo $i; tar tzf $i | LC_COLLATE=C sort > $i.files; done

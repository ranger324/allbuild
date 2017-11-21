#ls packages without description
ls *.deps | \
while read line; do
    PKG=${line%.deps}
    [ ! -e "$PKG.desc" ] && echo "$PKG"
done

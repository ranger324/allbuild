ls *.deps | \
while read line; do
    PKG=`echo "$line" | sed 's/\.deps$//'`
    [ ! -e "$PKG.desc" ] && echo "$PKG"
done

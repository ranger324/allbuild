#void
echo -n > _pkgdesc_void.txt
find -mindepth 1 -maxdepth 1 -type d | \
while read line; do
if [ -e $line/template ]; then
eval $(grep "^short_desc=" $line/template)
PKG=${line##*/}
echo "${PKG}:$short_desc" >> _pkgdesc_void.txt
fi
done

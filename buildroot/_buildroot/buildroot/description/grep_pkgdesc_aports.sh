#aports
echo -n > _pkgdesc_aports.txt
for i in */APKBUILD; do
eval $(grep "^pkgdesc=" $i)
echo "${i%/*}:$pkgdesc" >> _pkgdesc_aports.txt
done

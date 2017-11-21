#cat _pkgdesc.txt | cut -d : -f 1 | sort > _1
#cat _pkgdesc.txt | cut -d : -f 1 | sort -u > _2
cat _pkgdesc.txt | cut -d : -f 1 | sort | tee _1 | sort -u > _2
diff -Naur _1 _2 > _diff.patch
comm -23 --nocheck-order _1 _2 > _diff.list

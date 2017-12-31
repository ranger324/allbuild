#extract package files based on corelist file (corecore.lst)
[ -z "$1" ] && exit 1
PKGDIR=/home/packages
ls -1 $PKGDIR/*.pkg.tar.gz | sort | \
while read FNAME; do
    PKGNAME=$(echo $FNAME | sed 's%.*/%%' | rev | cut -d - -f 4- | rev)
    if grep -q "^$PKGNAME$" corecore.lst; then
	echo $PKGNAME
	tar xzf $FNAME -C "$1"
    fi
done

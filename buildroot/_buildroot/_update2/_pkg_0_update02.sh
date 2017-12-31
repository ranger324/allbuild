
BRDIR=/root/buildroot-2017.08.1

echo -n > _update.lst

for pkg in /tmp/*.1; do
    unset DIR
    unset VERSION
    source $pkg
    VER1=$VERSION

    file=`basename $pkg`
    pkgname=`echo "$file" | sed 's/\.1$//'`

    [ ! -e /tmp/$pkgname.2 ] && continue

    source /tmp/$pkgname.2
#    echo $DIR
    VER2=$VERSION
#    CMPSTR=`echo -ne "1#$VER1\n2#$VER2\n"`
#    CMPSTR2=`echo "$CMPSTR" | sort -V -t '#' -k 2`
    if [ "$VER1" != "$VER2" ]; then
#	echo $pkgname
	echo "$pkgname $VER1 -> $VER2" >> _update.lst
    fi
done

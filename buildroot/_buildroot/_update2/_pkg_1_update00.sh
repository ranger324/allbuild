#_VERSION_MINOR[[:space:]]\+=
BRDIR=/root/buildroot-2017.08.1

cp -Rdp package package-new

cut -d ' ' -f 1 _update.lst | \
while read pkgname; do
    unset DIR
    unset VERSION
    source /tmp/$pkgname.1

    OLD_VER_STR=`grep "_VERSION[[:space:]]\+=\|_VERSION_MAJOR[[:space:]]\+=\|_VERSION_MINOR[[:space:]]\+=\|_VERSION_UPSTREAM[[:space:]]\+=" package-new/$DIR/${pkgname}.mk`
    NEW_VER_STR=`grep "_VERSION[[:space:]]\+=\|_VERSION_MAJOR[[:space:]]\+=\|_VERSION_MINOR[[:space:]]\+=\|_VERSION_UPSTREAM[[:space:]]\+=" $BRDIR/package/$DIR/${pkgname}.mk`


    VER_MAJ=`echo "$OLD_VER_STR" | grep "_VERSION_MAJOR[[:space:]]\+="`
    VER_MIN=`echo "$OLD_VER_STR" | grep "_VERSION_MINOR[[:space:]]\+="`
    VER_UPS=`echo "$OLD_VER_STR" | grep "_VERSION_UPSTREAM[[:space:]]\+="`
    VER_DEF=`echo "$OLD_VER_STR" | grep "_VERSION[[:space:]]\+="`


    VER_MAJ2=`echo "$NEW_VER_STR" | grep "_VERSION_MAJOR[[:space:]]\+="`
    VER_MIN2=`echo "$NEW_VER_STR" | grep "_VERSION_MINOR[[:space:]]\+="`
    VER_UPS2=`echo "$NEW_VER_STR" | grep "_VERSION_UPSTREAM[[:space:]]\+="`
    VER_DEF2=`echo "$NEW_VER_STR" | grep "_VERSION[[:space:]]\+="`


    if [ ! -z "$VER_MAJ" ]; then
	sed -i "s%$VER_MAJ%$VER_MAJ2%" package-new/$DIR/${pkgname}.mk
    fi

    if [ ! -z "$VER_MIN" ]; then
	sed -i "s%$VER_MIN%$VER_MIN2%" package-new/$DIR/${pkgname}.mk
    fi

    if [ ! -z "$VER_UPS" ]; then
	sed -i "s%$VER_UPS%$VER_UPS2%" package-new/$DIR/${pkgname}.mk
    fi

    if [ ! -z "$VER_DEF" ]; then
	sed -i "s%$VER_DEF%$VER_DEF2%" package-new/$DIR/${pkgname}.mk
    fi

    [ -e $BRDIR/package/$DIR/${pkgname}.hash ] && cp $BRDIR/package/$DIR/${pkgname}.hash package-new/$DIR/${pkgname}.hash
done

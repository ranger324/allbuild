#_VERSION_MINOR[[:space:]]\+=
BRDIR=/root/buildroot-2017.08.1

for pkg in /tmp/*.1; do
    unset DIR
    unset VERSION
    source $pkg
    file=`basename $pkg`
    pkgname=`echo "$file" | sed 's/\.1$//'`

    if [ ! -z "$VERSION" ]; then


	if [ -e $BRDIR/package/$DIR/${pkgname}.mk ]; then

	    echo package/$DIR/${pkgname}.mk
	    echo "DIR=$DIR" > /tmp/${pkgname}.2
	    grep "_VERSION[[:space:]]\+=\|_VERSION_MAJOR[[:space:]]\+=\|_VERSION_MINOR[[:space:]]\+=\|_VERSION_UPSTREAM[[:space:]]\+=" $BRDIR/package/$DIR/${pkgname}.mk >> /tmp/${pkgname}.2
	    sed -i -e "s/[()]//g" -e "s/[[:space:]]\+//g" /tmp/${pkgname}.2
	    sed -i "s/\(.*\)_VERSION=\(.*\)$/VERSION=\2/" /tmp/${pkgname}.2

	fi


    fi
done

BRDIR=/root/buildroot-2017.08.1

find package -type f -name "Config.in" -printf "%P\n" | \
while read file; do
    DIR=`dirname $file`
    PKG=`basename $DIR`
    LSPATCH1=`find package/$DIR -mindepth 1 -maxdepth 1 -type f -name "*.patch"`
    if [ -e $BRDIR/package/$DIR ]; then
	LSPATCH2=`find $BRDIR/package/$DIR -mindepth 1 -maxdepth 1 -type f -name "*.patch"`
	NUM1=`echo "$LSPATCH1" | wc -l`
	NUM2=`echo "$LSPATCH2" | wc -l`
	[ "$NUM1" != "$NUM2" ] && echo $DIR
    fi
done

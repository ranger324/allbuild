for i in */.stamp_target_installed; do
    #pkgsource dir
    PKG=$(dirname $i)
    case $PKG in
	host-*|skeleton|toolchain|toolchain-buildroot) ;;
	initscripts|udev) ;;
	gcc-*|glibc-*|binutils-*) ;;
	*)
	    rm $PKG/.stamp_target_installed
	;;
    esac
done

for i in */.stamp_staging_installed; do
    #pkgsource dir
    PKG=$(dirname $i)
    case $PKG in
	host-*|skeleton|toolchain|toolchain-buildroot) ;;
	initscripts|udev) ;;
	gcc-*|glibc-*|binutils-*) ;;
	*)
	    rm $PKG/.stamp_staging_installed
	;;
    esac
done

GITDIR=`ls -d git-2.*`
rm $GITDIR/.stamp_configured
rm $GITDIR/.stamp_built

DIR=`ls -d libxml-parser-perl*`
rm -rf $DIR

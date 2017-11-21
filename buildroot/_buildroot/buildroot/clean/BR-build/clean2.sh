for i in */.stamp_target_installed; do
    PKG=$(dirname $i)
    case $PKG in
	host-*|skeleton|toolchain|toolchain-buildroot) ;;
	initscripts|udev) ;;
	*)
	    rm $PKG/.stamp_target_installed
	;;
    esac
done

for i in */.stamp_staging_installed; do
    PKG=$(dirname $i)
    case $PKG in
	host-*|skeleton|toolchain|toolchain-buildroot) ;;
	initscripts|udev) ;;
	*)
	    rm $PKG/.stamp_staging_installed
	;;
    esac
done

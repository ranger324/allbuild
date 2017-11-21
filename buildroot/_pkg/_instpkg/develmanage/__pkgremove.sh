#! /bin/bash

if PKGNAME=`pacman -Q eject 2> /dev/null`; then
    DIR=`echo "$PKGNAME" | tr ' ' -`
    test -d /var/lib/pacman/local/$DIR || exit 1
    cat /var/lib/pacman/local/$DIR/files | \
    while read file; do
	case "$file" in
	    %FILES%|"") continue;;
	    *)
		[ "$file" = "*/" ] && rmdir "/$file" > /dev/null 2>&1 || rm "/$file" > /dev/null 2>&1
		rm -rf /var/lib/pacman/local/$DIR
	    ;;
	esac
    done
fi
#pacman -Rdd --noconfirm --noprogressbar eject > /dev/null 2>&1

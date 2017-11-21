#! /bin/sh

tempfile=`mktemp 2> /dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

cat corecore.lst coredevel.lst corekernel.lst > corepkgs.lst

pacman -Q | cut -d ' ' -f 1 | \
while read PKG; do
    case $PKG in
	linux-R*) ;;
	*)    grep -qx "$PKG" corepkgs.lst || echo -n "$PKG " >> $tempfile;;
    esac
done

[ -s $tempfile ] && pacman -Rc `cat $tempfile`

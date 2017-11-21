remove(){

[ -z "$1" ] && return 1

if PKGNAME=`pacman -Q $1 2> /dev/null`; then
    DIR=`echo "$PKGNAME" | tr ' ' -`
    test -d /var/lib/pacman/local/$DIR || exit 1
    cat /var/lib/pacman/local/$DIR/files | \
    while read file; do
	case "$file" in
	    %FILES%|"") continue;;
	    */)
		#rm 
		rmdir "/$file" > /dev/null 2>&1
	    ;;
	    *)
		rm "/$file" > /dev/null 2>&1
	    ;;
	
	esac
    done
fi
}


for i in /var/lib/instpkg/packages/*; do
    [ -d $i ] || continue
    cd $i
    echo $i
    find -mindepth 1 | cpio -pdu --make-directories /

    rm -f $i/.files
    find -mindepth 1 | sort | sed 's%^\./%%' | \
    while read file; do
	[ -d "/$file" ] && echo "/$file/" >> $i/.files || echo "/$file" >> $i/.files
    done
done

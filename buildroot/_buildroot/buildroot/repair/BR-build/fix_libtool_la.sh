find -name "*.la" | xargs grep "/root/\|/sysroot/" | cut -d : -f 1 | sort -u | \
while read FILE; do
	source $FILE
	for i in $dependency_libs ; do
	case $i in
	    /root/*)
	    DEPFILE=$(basename $i)
	    sed -i "s%$i%/usr/lib/$DEPFILE%g" $FILE
	    ;;
	    -L/root/*)
	    sed -i "s%$i%-L/usr/lib%g" $FILE
	    ;;
	    -L/usr/x86_64*)
	    sed -i "s%$i%-L/usr/lib%g" $FILE
	    ;;
	esac
	done
done


#processed="@"
#[ "${processed}" = "${processed#*@$i@}" ]
#processed="${processed}${name}@"

#cd /dest; ls *.tar.gz | sed 's/\.tar\.gz$//' | rev | cut -d - -f 3- | rev | \
processed="@"
mkdir -p /dest/new
#cd ..
cd /dest
ls *.tar.gz > /dev/null 2>&1 || exit 1
(ls *.tar.gz | sed 's/\.tar\.gz$//' | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -r -k 1 -k 2V; echo "---") | \
while read name ver rev; do
    case $name in
	---)
	    echo "$o_name $o_ver $o_rev"
	;;
	*)
	    if [ -z "$o_name" ]; then
		o_name=$name
		o_ver=$ver
		o_rev=$rev
	    else
		if [ "$o_name" != "$name" ]; then
		    echo "$o_name $o_ver $o_rev"
		    o_name=$name
		    o_ver=$ver
		    o_rev=$rev
		else
		    if [ "$o_ver" = "$ver" ]; then
			if [ "$o_rev" -lt "$rev" ]; then
			    o_name=$name
			    o_ver=$ver
			    o_rev=$rev
			fi
		    fi
		fi
	    fi
	;;
	
    esac
done

exit 0

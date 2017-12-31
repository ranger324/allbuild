
#processed="@"
#[ "${processed}" = "${processed#*@$i@}" ]
#processed="${processed}${name}@"

#cd /dest; ls *.tar.gz | sed 's/\.tar\.gz$//' | rev | cut -d - -f 3- | rev | \
DIR_MV=/var/lib/instpkg/local
mkdir -p $DIR_MV/.!new
processed="@"
cd $DIR_MV
#ls | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -k 2V -k 3V -k 1 |  tac


#ls | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -k 1,2V | tac



#(ls | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -k 1 -k 2V; echo "---")
#(ls | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -k 1,2Vr; echo "---")
#exit 0

(ls | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -r -k 1 -k 2V; echo "---") | \
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
#    if [ "${processed}" = "${processed#*@$name@}" ]; then
#
#	mv $DIR_MV/"$name-$ver-$rev" $DIR_MV/.!new
#	processed="${processed}${name}@"
#    fi
done

exit 0

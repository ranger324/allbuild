
#processed="@"
#[ "${processed}" = "${processed#*@$i@}" ]
#processed="${processed}${name}@"

#cd /dest; ls *.tar.gz | sed 's/\.tar\.gz$//' | rev | cut -d - -f 3- | rev | \
DIR_MV=/var/lib/instpkg/local
mkdir -p $DIR_MV/.!new
processed="@"
cd $DIR_MV
ls | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -V -r -k 2,3 | \
while read name ver rev; do
    if [ "${processed}" = "${processed#*@$name@}" ]; then
	echo "$name $ver $rev"
#	mv $DIR_MV/"$name-$ver-$rev" $DIR_MV/.!new
	processed="${processed}${name}@"
    fi
done

exit 0

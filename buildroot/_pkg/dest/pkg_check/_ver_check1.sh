
#processed="@"
#[ "${processed}" = "${processed#*@$i@}" ]
#processed="${processed}${name}@"

#cd /dest; ls *.tar.gz | sed 's/\.tar\.gz$//' | rev | cut -d - -f 3- | rev | \
processed="@"
mkdir -p /dest/new
cd /dest
ls *.tar.gz > /dev/null 2>&1 || exit 1
ls *.tar.gz | sed 's/\.tar\.gz$//' | rev | sed 's/\([^-]\+\)-\([^-]\+\)-\(.*\)$/\1 \2 \3/' | rev | sort -V -r -k 2,3 | \
while read name ver rev; do
    if [ "${processed}" = "${processed#*@$name@}" ]; then
	echo "$name $ver $rev"
	mv /dest/"$name-$ver-$rev.tar.gz" /dest/new
	processed="${processed}${name}@"
    fi
done

exit 0

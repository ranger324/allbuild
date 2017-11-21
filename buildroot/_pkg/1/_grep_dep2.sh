#set +e

update_name_cache()
{
ls */info | xargs grep "^NAME=.*" > .name_cache
}

update_name_cache
sed -i -e 's%\(.*\)/\(.*\)%\1/\1/\2%' .name_cache
cat .name_cache |rev|sed 's%\(.*\)/\([0-9]\+\)-\([0-9a-z.]\+\)-\(.*\)%\1/ \2 \3 \4%'|rev > .name_cache2

deps="syslog-ng zlib"
deps=`echo "$deps"| sort -u`

echo -n > .name_cache2.tmp1
echo -n > .name_cache2.tmp2
echo -n > .name_cache2.tmp1.sort
echo -n > .name_cache2.tmp2.sort
while true; do
if test -s .name_cache2.tmp1.sort; then
    cp .name_cache2.tmp1.sort .name_cache2.tmp1
    for i in `cut -d / -f 2 .name_cache2.tmp1.sort`; do
	sort -u $i/depends | \
	while read line; do
	    grep "^$line " .name_cache2 >> .name_cache2.tmp1
	    retval=$?
	    if [ $retval != 0 ]; then
		echo "$line not found"
		exit 1
	    fi
	done
    done
    sort -u .name_cache2.tmp1 > .name_cache2.tmp1.sort
else
    for i in $deps; do
	grep "^$i " .name_cache2 >> .name_cache2.tmp1
	[ $? != 0 ] && echo "$i not found" && exit 1
    done
    sort -u .name_cache2.tmp1 > .name_cache2.tmp1.sort
fi

if cmp .name_cache2.tmp1.sort .name_cache2.tmp2.sort > /dev/null 2>&1; then
    break
else
    cp .name_cache2.tmp1.sort .name_cache2.tmp2.sort
fi

done

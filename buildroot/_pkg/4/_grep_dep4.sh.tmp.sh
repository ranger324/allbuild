#set +e
#[[ $TERM =~ ^rxvt.* || $TERM =~ ^screen.* ]]

ls */depend@ | xargs grep "." > .name_cache
find . -name depend@ -type f -size 0 | sed -e 's%^./%%' -e 's%.*%&:%' >> .name_cache
sort .name_cache | sed 's%\(.*\)/\(.*\)%\1/\1/\2%' | rev | \
	sed 's%\(.*\)/\([0-9]\+\)-\([0-9a-z.]\+\)-\(.*\)%\1/ \2 \3 \4%'| rev > .name_cache2

[ -z "$1" ] && exit 1
deps="$@"

echo -n > .name_cache2.tmp1
echo -n > .name_cache2.tmp2
echo -n > .name_cache2.tmp1.sort
echo -n > .name_cache2.tmp2.sort
echo "Getting dependencies..."
while true; do
if test -s .name_cache2.tmp1.sort; then
    cp .name_cache2.tmp1.sort .name_cache2.tmp1
    for i in `cut -d / -f 2 .name_cache2.tmp1.sort | xargs -i cat {}/depends | sort -u`; do
	grep "^$i " .name_cache2 >> .name_cache2.tmp1
	[ $? != 0 ] && echo "$i not found" && exit 1
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

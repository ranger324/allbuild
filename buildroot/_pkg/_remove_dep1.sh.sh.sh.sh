#set +e


#rem="eudev"
rem="zlib eudev"
#[ -z "$1" ] && exit 1
#rem="$@"

#check if package exists
cd .local
echo -n > ../.rem_cache.tmp1
echo -n > ../.rem_cache.tmp2
echo -n > ../.rem_cache.tmp1.sort
echo -n > ../.rem_cache.tmp2.sort
echo "Getting dependencies..."
while true; do
if test -s ../.rem_cache.tmp1.sort; then
    cp ../.rem_cache.tmp1.sort ../.rem_cache.tmp1
    for i in `cat ../.rem_cache.tmp1.sort`; do
	ls */depends | xargs grep "^$i$" | cut -d / -f 1 >> ../.rem_cache.tmp1
    done
    sort -u ../.rem_cache.tmp1 > ../.rem_cache.tmp1.sort
else
    for i in $rem; do
	ls */depends | xargs grep "^$i$" | cut -d / -f 1 >> ../.rem_cache.tmp1
    done
    if ! test -s ../.rem_cache.tmp1; then
	no_deps_to_remove=1
	break
    fi
    sort -u ../.rem_cache.tmp1 > ../.rem_cache.tmp1.sort
fi
if cmp ../.rem_cache.tmp1.sort ../.rem_cache.tmp2.sort > /dev/null 2>&1; then
    break
else
    cp ../.rem_cache.tmp1.sort ../.rem_cache.tmp2.sort
fi
done
###remove collected
###remove selected

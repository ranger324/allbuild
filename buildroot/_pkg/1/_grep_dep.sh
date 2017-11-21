#pkg_ext as param
update_name_cache()
{
ls */info | xargs grep "^NAME=.*" > .name_cache
}

#makes deps_ext to stdout from deps
ls_deps_ext()
{
echo "$deps" | \
while read pkgdep; do
    grep ":NAME=$pkgdep$" .name_cache2
done | \
while read pkgdep2; do
    PKG_EXT=`echo $pkgdep2 | cut -d '/' -f 2`
    PKG=`echo $pkgdep2 | cut -d '=' -f 2`
    echo "$PKG $PKG_EXT"
done
}

#    PKG_EXT=`echo $pkgdep2 | cut -d '/' -f 1`
#    PKG=`echo $pkgdep2 | cut -d '=' -f 2`

#deps=`echo -ne "syslog-ng\nzlib"`
deps="syslog-ng zlib"
deps_tmp=
deps_ext=
deps_ext_tmp=

#pkg=syslog-ng
#pkg_ext=`ls */info | xargs grep "^NAME=$pkg$" | cut -d '/' -f 1 `
update_name_cache
sed -i -e 's%\(.*\)/\(.*\)%\1/\1/\2%' .name_cache
cat .name_cache |rev|sed 's%\(.*\)/\([0-9]\+\)-\([0-9a-z.]\+\)-\(.*\)%\1/ \2 \3 \4%'|rev > .name_cache2

get_depline()
{
:
}

#deps=`echo "$deps"| sort -u`
#ls_deps_ext
echo -n > .name_cache2.tmp1
echo -n > .name_cache2.tmp2
echo -n > .name_cache2.tmp3
echo -n > .name_cache2.tmp1.sort
echo -n > .name_cache2.tmp2.sort
echo -n > .name_cache2.tmp3.sort
grep=0
sort=0
loop1=0
loop2=0
loop3=0
loop4=0
while true; do
(( loop1++ ))
if test -s .name_cache2.tmp1.sort; then
    
    for i in `cut -d / -f 2 .name_cache2.tmp1.sort`; do
(( loop3++ ))
	sort -u $i/depends | \
	while read line; do
(( loop4++ ))
	    grep "^$line " .name_cache2 >> .name_cache2.tmp3
(( grep++ ))
	done
    done
    cp .name_cache2.tmp3 .name_cache2.tmp1
    sort -u .name_cache2.tmp1 > .name_cache2.tmp1.sort
(( sort++ ))
else
    for i in $deps; do
(( loop2++ ))
	grep "^$i " .name_cache2 >> .name_cache2.tmp1
(( grep++ ))
    done
    sort -u .name_cache2.tmp1 > .name_cache2.tmp1.sort
(( sort++ ))
fi

if cmp .name_cache2.tmp1.sort .name_cache2.tmp2.sort > /dev/null 2>&1; then
    break
else
    cp .name_cache2.tmp1.sort .name_cache2.tmp2.sort
fi

done

echo grep=$grep
echo sort=$sort
echo loop1=$loop1
echo loop2=$loop2
echo loop3=$loop3
echo loop4=$loop4

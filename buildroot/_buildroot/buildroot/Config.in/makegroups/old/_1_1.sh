[ "$1" = "-c" ] && chk=1
#main groups
sh _get_groups4.sh | \
grep -v "package/x11r7/Config\.in" | tee _pkgs.group | \
sed 's%[[:space:]]\+source[[:space:]]\+"package/.*/Config\.in"%%' | sort -u > _pkgs.group.out

[ $chk ] && cp _pkgs.group _pkgs.group.chk

cat _pkggroups.def | \
while read line; do
    REP_SOURCE=`echo "$line" | cut -d '#' -f 1 | tr -d '"'`
    REP_TARGET=`echo "$line" | cut -d '#' -f 2`
    sed -i "s%\"$REP_SOURCE\"[[:space:]]\+source%$REP_TARGET%" _pkgs.group
done
sed -i 's/"//g' _pkgs.group
echo "libs graphics package/jpeg-turbo/Config.in" >> _pkgs.group
sort _pkgs.group > _pkgs.group.tmp
mv _pkgs.group.tmp _pkgs.group

#x11r7 groups
sh _get_groups4.sh@x11r7.sh > _pkgs.x11r7
cat _pkgs.x11r7 | sed 's%[[:space:]]\+source[[:space:]]\+package/.*/Config\.in%%' | sort -u > _pkgs.x11r7.out

[ $chk ] && cp _pkgs.x11r7 _pkgs.x11r7.chk

cat _pkggroups_x11r7.def | \
while read line; do
    REP_SOURCE=`echo "$line" | cut -d '#' -f 1 | tr -d '"'`
    REP_TARGET=`echo "$line" | cut -d '#' -f 2`
    sed -i "s%\"$REP_SOURCE\"[[:space:]]\+source%$REP_TARGET%" _pkgs.x11r7
done

#other groups (non-menu)
sh _ls_other_pkgs.sh | tee _pkgs.other | \
grep -o ".*/Config\.in:[[:space:]]*source" | sort -u > _pkgs.other.out

[ $chk ] && cp _pkgs.other _pkgs.other.chk

cat _pkggroups_other.def | \
while read line; do
    REP_SOURCE=`echo "$line" | cut -d '#' -f 1`
    REP_TARGET=`echo "$line" | cut -d '#' -f 2`
    sed -i "s%$REP_SOURCE%$REP_TARGET%" _pkgs.other
done
sed -i 's/"//g' _pkgs.other

cat _pkgs.group _pkgs.x11r7 _pkgs.other | sort -u > _pkgs.group@@@@

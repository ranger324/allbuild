#delete lines where
##procedure() {
##}
cp a.install.tmp a.install
anum=0
grep -A 1 -n "() {$" a.install | grep "^[0-9]\+-}$" | sed "s/-}$//" | \
while read num; do
    sed -i "$(expr $num - $anum)d" a.install
    sed -i "$(expr $num - 1 - $anum)d" a.install
    anum=$(expr $anum + 2)
done

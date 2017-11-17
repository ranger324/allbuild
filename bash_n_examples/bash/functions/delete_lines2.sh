#delete lines where
##procedure() {
##}
cp a.install.tmp a.install
grep -A 1 -n "() {$" a.install

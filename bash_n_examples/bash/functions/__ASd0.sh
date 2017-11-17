#S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"
#S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))"
#S="asd \$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"
S="asd \$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))"
echo "$S"

##!not separating sections
echo "+++"
echo -n "$S" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
if [ "$PP" = "$MM" ]; then
    if [ "$A" != "-" ]; then
	echo -n "$A"
    fi
fi
done
echo
echo "---"

##!not separating sections
echo "+++"
echo -n "$S" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
[ -z "$oeq" -a -n "$eq" ] && echo -n "-"
if [ "$PP" != "$MM" ]; then
    echo -n "$A"
fi
done | \
sed -e 's/+/$(/g' -e 's/-/)/g'
echo
echo "---"

##space separating sections
echo "+++"
echo -n "$S" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
[ -z "$oeq" -a -n "$eq" ] && echo -n "- "
if [ "$PP" != "$MM" ]; then
    echo -n "$A"
fi
done | \
sed -e 's/+/$(/g' -e 's/-/)/g'
echo
echo "---"

##linefeed separating sections
echo "+++"
(echo -n "$S"; echo -n ")") | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
[ \( -z "$oeq" -a -n "$eq" \) -a -n "$val" ] && echo && val=
[ \( "$MM" -gt "$PP" \) -a -n "$val" ] && echo && val=
if [ "$PP" = "$MM" ]; then
    [ "$A" != "-" ] && echo -n "$A" && val=1
fi
done
echo "---"

##linefeed separating sections
echo "+++"
echo -n "$S" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
[ -z "$oeq" -a -n "$eq" ] && echo -n "-" && echo
if [ "$PP" != "$MM" ]; then
    echo -n "$A"
fi
done | \
sed -e 's/+/$(/g' -e 's/-/)/g'
echo "---"

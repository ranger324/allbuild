#S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"
#S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))"
#S="asd \$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"
S="asd \$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))"

echo "$S"

##linefeed separating sections
echo "***"
(echo -n "$S"; echo -n ")") | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
if [ -n "$oeq" -a -n "$eq" -a "$PP" = "$MM" ]; then
    echo -n "$A"
    val=1
fi
if [ -n "$oeq" -a -z "$eq" -a "$PP" != "$MM" ]; then
    [ -n "$val" ] && echo && val=
fi
done

##linefeed separating sections
echo "***"
echo -n "$S" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
if [ \( -z "$oeq" -a -n "$eq" -a "$PP" = "$MM" \) -o \( "$PP" != "$MM" \) ]; then
    echo -n "$A"
    [ "$PP" = "$MM" ] && echo
fi
done | \
sed -e 's/+/$(/g' -e 's/-/)/g'

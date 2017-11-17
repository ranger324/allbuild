#S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"
#S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))"
#S="asd \$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"

S="asd \$(if \$(s\$(g)), \$(z))sd \$(asds \$(asd))"
##!spaces! without separating static strings
#
#S="asd\$(if \$(s\$(g)), \$(z))sd \$(asds \$(asd))"

echo "$S"


echovars()
{
parm="$@"
echo -n "$parm" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
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
}



echovars_linefeed()
{
parm="$@"
echo -n "$parm" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
[ -z "$oeq" -a -n "$eq" ] && echo "-"
if [ "$PP" != "$MM" ]; then
    echo -n "$A"
fi
done | \
sed -e 's/+/$(/g' -e 's/-/)/g'
}


echostatic()
{
(echo -n "$S"; echo -n ")") | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$PP" = "$MM" ] && oeq=1 || oeq=
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
[ "$PP" = "$MM" ] && eq=1 || eq=
[ \( -z "$oeq" -a -n "$eq" \) -a -n "$val" ] && echo -n " " && val=
[ \( "$MM" -gt "$PP" \) -a -n "$val" ] && echo -n " " && val=
if [ "$PP" = "$MM" ]; then
    [ "$A" != "-" ] && echo -n "$A" && val=1
fi
done
echo
}

echo "**"
echovars "$S"
echo "**"
echovars_linefeed "$S"
echo "**"
echostatic "$S"
echo "**"
for i in `echostatic "$S"`; do
    echo "$i"
done
echo "**"

S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"
#S="\$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))"
#S="asd \$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))dsa"
#S="asd \$(asda\$(s\$(g)), \$(z))sd \$(asds \$(asd))"
echo "$S"

##linefeed separating sections
echo "+++"
(echo -n "$S"; echo -n ")") | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
if [ "$PP" = "$MM" ]; then
    if [ "$A" != "-" ]; then
	echo -n "$A"
	val=1
    fi
else
    [ "$A" = "-" ] && [ -n "$val" ] && echo && val=
fi
done
echo "---"


##linefeed separating sections
echo "+++"
echo -n "$S" | sed -e 's/\$(/+/g' -e 's/)/-/g' | \
while read -r -N 1 A; do
[ -z "$PP" ] && PP=0
[ -z "$MM" ] && MM=0
[ "$A" = "+" ] && PP=$(expr $PP + 1)
[ "$A" = "-" ] && MM=$(expr $MM + 1)
if [ "$PP" = "$MM" ]; then
    if [ -n "$val" ]; then
	echo "-"
	val=
    fi
else
    echo -n "$A"
    val=1
fi
done | \
sed -e 's/+/$(/g' -e 's/-/)/g'
echo "---"

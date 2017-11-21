A="	a sd as"
echo "*${A}*"
echo "${A//[[:space:]]/}"
echo $A
for i in $A; do
echo "$i"
done

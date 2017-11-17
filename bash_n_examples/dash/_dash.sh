echo asd asd | while read -r asd; do
echo ${asd#*a}
#echo ${asd/a/b}
done
echo "**$asd"

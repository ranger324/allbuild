find -path "./init" -prune -o \( -name "ignite*" -o -name "star*" \) -print
echo
find -path "./init" -prune -o -type f \( -name "ignite*" -o -name "star*" \) -print
echo
#find -type f -path "./init/*" -prune -o \( -name "ignite*" -o -name "star*" \) -print
#echo

find -path "./init" -prune -o -type f -name "ignite*" -print

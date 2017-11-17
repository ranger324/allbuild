#dash IFS
#IFS="
#"

A=1
#set -- "${@:1:2}" "new" "${@:4}"
#set -- "a'b" a 'd f' " ' " '"' '\"$A' "$A"
#set -- "a'b" a 'd f' " ' " '"' '$A' "$A"

echo "params:*$@*"

pars="$@"
echo "pars*$pars*"

echo 1
for pars; do
echo "*$pars*"
done

OIFS=$IFS
IFS="
"
parl="$*"
IFS=$OIFS

echo "parl*${parl}*"

echo 2
OIFS=$IFS
IFS="
"
for pattern in $parl; do
echo "*$pattern*"
done
IFS=$OIFS

#+
#set -- "${@:1:2}" "new" "${@:4}"
#set -- -ne "1\n2\n"
############
OIFS=$IFS
IFS="
"
set -- -ne "1\n2\n"
echo "$*"
echo "$@"
IFS=$OIFS

OIFS=$IFS
IFS=
set -- -ne "1\n2\n"
echo "$*"
echo "$@"
IFS=$OIFS

set -- -ne "1\n2\n"
echo "a$*"
echo "a$@"
############
A=1
#set -- "${@:1:2}" "new" "${@:4}"
#set -- "a'b" a 'd f' " ' " '"' '\"$A' "$A"
set -- "a'b" a 'd f' " ' " '"' '$A' "$A" '-$' '-\$'

echo "params:*$@*"
echo "#######"

OIFS=$IFS
IFS="
"
param="$*"
IFS=$OIFS


OIFS=$IFS
IFS="
"
for i in $param; do
    echo "*$i*"
done
IFS=$OIFS


#echo "*$param*"

tmpvar=
OIFS=$IFS
IFS="
"
for pattern in $param; do
#if [ "$pattern" != "${pattern#*'}" ]; then
#bash
if [ "$pattern" != "${pattern#*\'}" ]; then
    if [ "$pattern" != "${pattern#-}" ]; then
	[ -z "$tmpvar" ] && tmpvar="\"\\$pattern\"" || tmpvar="$tmpvar \"\\$pattern\""
    else
	[ -z "$tmpvar" ] && tmpvar="\"$pattern\"" || tmpvar="$tmpvar \"$pattern\""
    fi
else
    if [ "$pattern" != "${pattern#-}" ]; then
	[ -z "$tmpvar" ] && tmpvar="'\\$pattern'" || tmpvar="$tmpvar '\\$pattern'"
    else
	[ -z "$tmpvar" ] && tmpvar="'$pattern'" || tmpvar="$tmpvar '$pattern'"
    fi
fi
done
IFS=$OIFS

eval set -- $tmpvar

OIFS=$IFS
IFS="
"
param="$*"
IFS=$OIFS

echo "#######"

OIFS=$IFS
IFS="
"
for i in $param; do
    echo "*$i*"
done
IFS=$OIFS

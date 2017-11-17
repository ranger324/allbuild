echo $#
echo "$@"
parms="$@"
A="$#"
B="$"
echo "$A"

eval C='$'$A
echo "$C"
eval D=\${$#}
echo "$D"
eval E=\${$A}
echo "$E"
eval F=\$$A
echo "$F"
echo "${!#}"

echo ASD
echo "$parms"
echo ASD
for parms; do true; done
echo "$parms"

lastparam="$@"
for lastparam; do true; done
echo "$lastparam"

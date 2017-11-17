
A=1
var1="  a b  c"
B="  a b  c"
eval D=\${var${A}}
eval E=\$var${A}
eval F='$'{var${A}}
eval G='$'var${A}
echo "$D"
echo "$E"
echo "$F"
echo "$G"
eval echo \${var${A}}
eval echo \"\${var${A}}\"
eval echo "\"\${var${A}}\""

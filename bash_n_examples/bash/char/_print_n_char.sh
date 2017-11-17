print_n_char()
{
local char="$1"
local num="$2"
local A
A=$(printf "%${num}c" " ")
echo "${A// /${char}}"
}

print_n_char "0" 5
printf "%s" {a..z}
echo
printf "%s" {1..10}
echo


A=1
B=
num=10
for i in $(seq 1 $num); do
B="$B$A"
done
echo "$B"

A=1
B=
num=10
for ((i=0; i<${num}; i++)) do
B="$B$A"
done
echo "$B"

A=1
num=10
for ((i=0; i<${num}; i++))
{
echo -ne "$A"
}

echo


#A="a"
#num=10
#printf "%.0s${A}" $(seq 1 ${num})
#echo
#A="a"
#printf "%.0s${A}" {1..10}
#echo



printf "%.5s" aasdaaas
echo

printf "%-.5s" aasdaaas
echo

#A=${A:0:${#A}}

A=1234567890
A=${A::${#A}-4}
echo "$A"

#bash
A=1234567890
A=${A::-4}
echo "$A"

A=1234567890
A=${A:4:${#A}}
echo "$A"

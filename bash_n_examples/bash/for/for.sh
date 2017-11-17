for ((i=0; i<100; i++)); do pidof bash; done

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
#for ((i=0; i<${num}; i++)) do
for ((i=0; i<num; i++)) do
B="$B$A"
done
echo "$B"

A=1
num=10
#for ((i=0; i<${num}; i++))
for ((i=0; i<num; i++))
{
echo -ne "$A"
}
echo

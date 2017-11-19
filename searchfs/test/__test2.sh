N=1
N2=$(printf "%3d" $N | tr ' ' '0')
NUM=`ls ___@*.???_1 | wc -l`
while [ "$N" -le "$NUM" ]; do
    NAME1=`ls ___@*.${N2}_1`
    NAME2=`ls ___@*.${N2}_2`
    cmp ___@*.${N2}_1 ___@*.${N2}_2 && echo "$NAME1->$NAME2 ok"
    N=$(( $N + 1 ))
    N2=$(printf "%3d" $N | tr ' ' '0')
done

#N=0
#NUM=`ls ___@*.???_1 | wc -l`
#while [ "$N" -lt "$NUM" ]; do
#    N=$(( $N + 1 ))
#    N2=$(printf "%3d" $N | tr ' ' '0')
#    NAME1=`ls ___@*.${N2}_1`
#    NAME2=`ls ___@*.${N2}_2`
#    cmp ___@*.${N2}_1 ___@*.${N2}_2 && echo "$NAME1->$NAME2 ok"
#done

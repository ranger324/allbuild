N=1
N2=$(printf "%3d" $N | tr ' ' '0')
sh __call_lsgroups2.sh | grep -v "\.tags\|00comm" | \
while read group; do
    sh _find_group_defs.sh "$group" | sort > ___@$group.${N2}_1
    sh _find_group_defs.sh -a "$group" | sort > ___@$group.${N2}_2
    N=$(( $N + 1 ))
    N2=$(printf "%3d" $N | tr ' ' '0')
done

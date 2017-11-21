set -f

#set noglob
#shopt -s nullglob
#shopt -u direxpand
#shopt -u globstar

IFS1=$IFS
IFS=$'\n'
num=0
for line in $(cat _group); do
    users=`echo "$line" | cut -d : -f 4-`
    group=`echo "$line" | cut -d : -f 1`
    if [ ! -z "$users" ]; then
	IFS2=$IFS
	IFS=$','
	for i in $users; do
	    num=$(expr $num + 1)
	    eval user${num}="$i"
	    eval user${num}user${num}="$group"
	done
	IFS=$IFS2
    fi
done
IFS=$IFS1

for i in `seq 1 $num`; do
    eval echo -n '$'user${i}
    echo -n ":"
    eval echo '$'user${i}user${i}
done

exit 0

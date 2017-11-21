set -f

#set noglob
#shopt -s nullglob
#shopt -u direxpand
#shopt -u globstar

cat _group | \
while read line; do
    users=`echo "$line" | cut -d : -f 4-`
    group=`echo "$line" | cut -d : -f 1`
    if [ ! -z "$users" ]; then
	IFS1=$IFS
	IFS=$','
	for i in $users; do
	    echo "$i:$group"
	done
	IFS=$IFS1
    fi
done

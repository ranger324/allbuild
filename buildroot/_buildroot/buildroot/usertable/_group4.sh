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
done | sort > /tmp/file

#sorted list
ouser=
groups=
while read line; do
    user=${line%:*}
    group=${line#*:}
    if [[ "$ouser" != "$user" ]]; then
	if [[ -z "$ouser" ]]; then
	    groups="$group"
	else
	    echo "$ouser:$groups"
	    groups="$group"
	fi
	ouser="$user"
    else
	[[ -z "$groups" ]] && groups="$group" || groups="$groups,$group"
    fi
done < /tmp/file
##!notice! check we went through while :[[]]
[[ ! -z "$user" ]] && echo "$user:$groups"

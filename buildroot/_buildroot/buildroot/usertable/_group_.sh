set -f

#set noglob
#shopt -s nullglob
#shopt -u direxpand
#shopt -u globstar



IFS1=$IFS
IFS=$'\n'
NUMUSER=0
for line in $(cat _group); do
    users=`echo "$line" | cut -d : -f 4-`
    group=`echo "$line" | cut -d : -f 1`
    if [ ! -z "$users" ]; then
    IFS2=$IFS
    IFS=$','
    for i in $users; do
	NUMUSER=$(expr $NUMUSER + 1)
	[ -z "$userslist" ] && userslist="$i:user$NUMUSER" || userslist=`echo -ne "$userslist\n$i:user$NUMUSER"`
	
    done
    IFS=$IFS2
    fi
done
IFS=$IFS1

#echo "$NUMUSER"
IFS1=$IFS
IFS=$'\n'
#NUMUSER=0
for line in $(cat _group); do
    users=`echo "$line" | cut -d : -f 4-`
    group=`echo "$line" | cut -d : -f 1`
    if [ ! -z "$users" ]; then
    IFS2=$IFS
    IFS=$','
    for i in $users; do
	IFS3=$IFS
	IFS=$'\n'
	NUMUSER=0
	for j in $userslist; do
	    NUMUSER=$(expr $NUMUSER + 1)
	    AA=`echo $j | cut -d : -f 1`
	    BB=`echo $j | cut -d : -f 2`
	    if [ "$i" = "$AA" ]; then
		[ -z "$(eval echo '$'$BB)" ] && \
		    eval $BB="$group" || eval $BB="$(eval echo '$'$BB),$group"
	    fi
	done
	IFS=$IFS3
    done
    IFS=$IFS2
    fi
done
IFS=$IFS1


	IFS1=$IFS
	IFS=$'\n'
	for i in $userslist; do
	    AA=`echo $i | cut -d : -f 1`
	    BB=`echo $i | cut -d : -f 2`

	    echo -n "$AA:"
	    eval echo '$'$BB
	done
	IFS=$IFS1

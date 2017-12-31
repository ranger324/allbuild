set -f

F_PASSWD="/etc/passwd"
F_GROUP="/etc/group"

FILE=_users_table.txt
#FILE=/tmp/file
#sh _find_users_table_entries4.sh -n > $FILE
cat $FILE | \
while read username uid group gid passwd home shell groups comment; do
if [ "$group" != "-" ]; then
    GRPID=`grep "^${group}:" "$F_GROUP" | cut -d : -f 3`
    if [ -z "$GRPID" ]; then
	echo "#**Group not found: ${group}**"
    else
	if ! echo "$processed" | grep -q "^${group}$"; then
	    echo "addgroup -g $GRPID $group"
	    [ -z "$processed" ] && processed="$group" || processed=`echo -ne "$processed\n$group"`
	fi
    fi
fi
if [ "$groups" != "-" ]; then
    OIFS=$IFS
    IFS=$','
    for i in $groups; do
	GRPID=`grep "^${i}:" "$F_GROUP" | cut -d : -f 3`
	if [ -z "$GRPID" ]; then
	    echo "#**Group not found: ${i}**"
	else
	    if ! echo "$processed" | grep -q "^${i}$"; then
		echo "addgroup -g $GRPID $i"
		[ -z "$processed" ] && processed="$i" || processed=`echo -ne "$processed\n$i"`
	    fi
	fi
    done
    IFS=$OIFS
fi
done

cat $FILE | \
while read username uid group gid passwd home shell groups comment; do
[ "$shell" != "-" ] && SHELL="-s $shell" || SHELL=
[ "$home" != "-" ] && HHOME="-h $home" || HHOME=
[ "$group" != "-" ] && GROUP="-G $group" || GROUP=
[ "$comment" != "-" -a ! -z "$comment" ] && COMMENT="-g '$comment'" || COMMENT=
if [ "$username" != "-" ]; then
    USRID=`grep "^${username}:" "$F_PASSWD" | cut -d : -f 3`
    if [ -z "$USRID" ]; then
	echo "#**User not found: ${username}**"
    else
	echo "adduser $HHOME $COMMENT $GROUP $SHELL -D -H -u $USRID $username"
	if [ "$groups" != "-" ]; then
	    OIFS=$IFS
	    IFS=$','
	    for i in $groups; do
		echo "adduser $username $i"
	    done
	    IFS=$OIFS
	fi
    fi
fi
done

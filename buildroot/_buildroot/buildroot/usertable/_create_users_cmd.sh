set -f

FILE=_users_table.txt
#FILE=/tmp/file
#sh _find_users_table_entries4.sh -n > $FILE
cat $FILE | \
while read username uid group gid passwd home shell groups comment; do
if [ "$group" != "-" ]; then
    if ! echo "$processed" | grep -q "^${group}$"; then
	echo "addgroup -g \$(sh /bin/_get_next_group.sh 1000) $group"
	[ -z "$processed" ] && processed="$group" || processed=`echo -ne "$processed\n$group"`
    fi
fi
if [ "$groups" != "-" ]; then
    OIFS=$IFS
    IFS=$','
    for i in $groups; do
	if ! echo "$processed" | grep -q "^${i}$"; then
	    echo "addgroup -g \$(sh /bin/_get_next_group.sh 1000) $i"
	    [ -z "$processed" ] && processed="$i" || processed=`echo -ne "$processed\n$i"`
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
    echo "adduser $HHOME $COMMENT $GROUP $SHELL -D -H -u \$(sh /bin/_get_next_user.sh 1000) $username"
    if [ "$groups" != "-" ]; then
	OIFS=$IFS
	IFS=$','
	for i in $groups; do
	    echo "adduser $username $i"
	done
	IFS=$OIFS
    fi
fi
done

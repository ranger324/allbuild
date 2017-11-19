find -type f -name "*.groupident" | \
sed "s%/[^/]\+$%%" | sed 's%.*%&/%' | sort -Vu | sed 's%/$%%'| \
#^ better output with "sed 's%.*%&/%' | sort -Vu | sed 's%/$%%'" if it would stop here
#v rework [0-9][0-9]comm; rework .tags
while read listdir0; do
    case "$listdir0" in
    */.tags)
	#cut from *.tagident added ((listdir0)+/group...) !notice! no sort in find
	echo -n "$listdir0"
	find $listdir0 -type f -name "*.tagident" | sed 's%\.tagident$%%' | \
	while read listdir3; do
	    echo -n "/$(basename "$listdir3")"
	done
	echo
    ;;
    */[0-9][0-9]comm)
	#cut from *.commident added ((listdir0)+/group...) !notice! no sort in find
	echo -n "$listdir0"
	find $listdir0 -type f -name "*.commident" | sed 's%\.commident$%%' | \
	while read listdir3; do
	    echo -n "/$(basename "$listdir3")"
	done
	echo
    ;;
    *)
	echo "$listdir0"
    ;;
    esac
done | \
sed -e 's%^\./%@%' -e 's%/%@%g' -e 's%.*%&@%'

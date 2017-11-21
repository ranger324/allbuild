#IFS=
printfile=1
[ "$1" = "-n" ] && printfile=
set -f
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read line; do
    sh _find_file_section.sh -i "$line" "^define[[:space:]]\+.*_USERS" "^endef"
done | \
while read -r uline; do
	case "$uline" in
	---*)
	    file=`echo "$uline" | sed 's/^---//'`
	    [ ! -z "$printfile" ] && echo "$file"
	;;
	\$\(*)
	    VAR=`echo "$uline" | sed -e 's/^$(//' -e 's/)$//'`
	    grep "^$VAR[[:space:]]\+[+:=-]\+[[:space:]]\+" "$file" | sed -n 's/^\([^+:=-]\+[+:=-]\+[[:space:]]\+\)\(.*\)/\2/p'
	;;
	*)
	    echo "$uline"
	;;
	esac
done

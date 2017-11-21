printfile=1
[ "$1" = "-n" ] && printfile=

find_file_section()
{
file="$1"
grep1="$2"
grep2="$3"
NUMS=$(grep -n "$grep1" "$file" | cut -d : -f 1)
for i in $NUMS; do
	ENDNUMA=$(tail -n +$i "$file" | grep -n "$grep2" | head -n 1 | cut -d : -f 1)
	if [ -z "$ENDNUMA" ]; then
	    ENDNUMA=1
	    [ ! -z "$printfile" ] && echo "---$file *"
	else
	    [ ! -z "$printfile" ] && echo "---$file"
	fi
	if [ "$ENDNUMA" = 1 ]; then
	    echo "Pattern not found: $grep2"
	else
	    tail -n +$(expr $i + 1) "$file" | head -n $(expr $ENDNUMA - 2) | \
	    while read -r uline; do
		case "$uline" in
		    \$\(*)
			VAR=`echo "$uline" | sed -e 's/^$(//' -e 's/)$//'`
			grep "^$VAR[[:space:]]\+[+:=-]\+[[:space:]]\+" "$file" | sed -n 's/^\([^+:=-]\+[+:=-]\+[[:space:]]\+\)\(.*\)/\2/p'
		    ;;
		    *)
			echo "$uline"
		    ;;
		esac
	    done
	fi
done
}
set -f
#find -mindepth 2 -type f -name "*.mk" | \
find -mindepth 2 -type f -name "*.mk" ! -path "./gcc/*" ! -path "./tzdata/*" | \
while read line; do
    find_file_section "$line" "^define[[:space:]]\+.*_USERS" "^endef"
done

##! ":" char
##todo deal with [[:space:]] filename
export LC_COLLATE=C
IFS=$'\n'
find -type f | while read file; do
    FILE=${file##*/}
    DIR=${file%/*}
    echo "$FILE:$DIR"
done > /tmp/file1

sort /tmp/file1 > /tmp/file2

OPKG=
DEPP=
while read line; do
    PKG=${line%%:*}
    DEP=${line##*:}
    if [[ "$OPKG" != "$PKG" ]]; then
	if [[ -z "$OPKG" ]]; then
	    DEPP="$DEP"
	else
	    echo "$OPKG:$DEPP"
	    DEPP="$DEP"
	fi
	OPKG="$PKG"
    else
	[[ -z "$DEPP" ]] && DEPP="$DEP" || DEPP="$DEPP $DEP"
    fi
done < /tmp/file2 > /tmp/file3
##!notice! check we went through while :[[]]
[[ ! -z "$PKG" ]] && echo "$PKG:$DEPP" >> /tmp/file3

grep "^.*:.*[[:space:]]\+.*$" /tmp/file3

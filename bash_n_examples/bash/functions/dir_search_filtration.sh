# find target files in directories extracting focused directories filtered by needed to be processed

lsall()
{
find -type f -name "list.identident" | \
##wo LC_COLLATE
#sed "s%list.identident$%%" | sort -V | sed 's%/$%%' | \
sed "s%list.identident$%%" | sort | sed 's%/$%%' | \
while read listdir; do
    if [[ -z "$olistdir" ]]; then
	olistdir="$listdir"
	find $listdir -type f \( ! -name "*.*ident" \)
    else
	if [[ ! "$listdir" =~ ^$olistdir/.* ]]; then
	    olistdir="$listdir"
	    find $listdir -type f \( ! -name "*.*ident" \)
	fi
    fi
done
}


lsall2()
{
local params="$@"
echo "$params" | \
while read i; do
    find -type f -name "*@$i@*.groupident"
done | \
##wo LC_COLLATE
sed -e 's%/[^/]\+$%%' -e 's%.*%&/%' | sort -Vu | sed 's%/$%%' | \
sed -n 's%\(.*/\)[^/]\+$%\1%p' | sort -Vu | sed 's%/$%%' | \
##w LC_COLLATE
sed -e 's%/[^/]\+$%%' -e 's%.*%&/%' | sort -u | sed 's%/$%%' | \
sed -n 's%\(.*/\)[^/]\+$%\1%p' | sort -u | sed 's%/$%%' | \
while read listdir; do
    if [[ -z "$olistdir" ]]; then
	olistdir="$listdir"
	find $listdir -type f \( ! -name "*.*ident" \)
    else
	if [[ ! "$listdir" =~ ^$olistdir/.* ]]; then
	    olistdir="$listdir"
	    find $listdir -type f \( ! -name "*.*ident" \)
	fi
    fi
done
}


export LC_COLLATE=C


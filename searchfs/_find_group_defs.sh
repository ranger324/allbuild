#
#keep your files organized (in place)
#put them into directories - name directories (subcategories)
#(some additional files will be created :( )
#
#-put common category files into ??comm directory (where ? is a
#numeric character) and create something.commident files to identify
#category. (touch something.commident)
#
#-put alternate group names (only the ident-file) to .tags directory
#by creating something.tagident files. (touch something.tagident)
#
#init:
#sh _init_searchfs.sh
#clear:
#sh _clear_searchfs.sh
#
#find: (shell filename expansion "*cmd" "?*")
#sh _find_group_defs.sh -a cmd script prog
#sh _find_group_defs.sh -a cmd script -prog
#sh _find_group_defs.sh -o cmd script prog
#sh _find_group_defs.sh -a bash example | xargs -r grep sed
#
#-o or (group .. group)
#-a and (group where "true" some other group)
#default is -o
#
#invert search group names like -compress (only in "and" mode (-a))
#other option: "*" (list groups)
#without parameter: list all

lsall()
{
find -type f -name "list.identident" | \
sed 's%list.identident$%%' | sort | sed 's%/$%%' | \
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

lsgroups()
{
    find -type f -name "*.groupident" | \
    sed -e 's%/[^/]\+$%%' -e 's%.*%&/%' | sort -u | sed 's%/$%%' | \
    while read listdir0; do
    case "$listdir0" in
    */.tags)
	echo -n "$listdir0"
	find $listdir0 -type f -name "*.tagident" | sed 's%\.tagident$%%' | \
	while read listdir3; do
	    echo -n "/$(basename "$listdir3")"
	done
	echo
    ;;
    */[0-9][0-9]comm)
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
}

lsor()
{
local params="$@"
echo "$params" | \
while read i; do
    find -type f -name "*@$i@*.groupident"
done | \
sed -e 's%/[^/]\+$%%' -e 's%/\.tags$%%' -e 's%.*%&/%' | \
sort -u | sed 's%/$%%' | \
while read listdir2; do
    if [[ -z "$olistdir2" ]]; then
	olistdir2="$listdir2"
	find $listdir2 -type f -name "list.identident"
    else
	if [[ ! "$listdir2" =~ ^$olistdir2/.* ]]; then
	    olistdir2="$listdir2"
	    find $listdir2 -type f -name "list.identident"
	fi
    fi
done | sed 's%/list.identident$%%' | \
sed 's%.*%&/%' | sort | sed 's%/$%%' | \
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

lsand()
{
##for "for" loop
set -f

local params="$@"
echo "$params" | \
while read i; do
    if [[ "${i::1}" != "-" ]]; then
	find -type f -name "*@$i@*.groupident"
    fi
done | sed -e 's%/[^/]\+$%%' -e 's%.*%&/%' | sort -u | sed 's%/$%%' | \
while read listdir0; do
    case "$listdir0" in
    */.tags)
	echo -n "$listdir0"
	find $listdir0 -type f -name "*.tagident" | sed 's%\.tagident$%%' | \
	while read listdir3; do
	    echo -n "/$(basename "$listdir3")"
	done
	echo
    ;;
    */[0-9][0-9]comm)
	echo -n "$listdir0"
	find $listdir0 -type f -name "*.commident" | sed 's%\.commident$%%' | \
	while read listdir3; do
	    echo -n "/$(basename "$listdir3")"
	done
	echo
    ;;
    *)
	find $listdir0 -type f -name "*.groupident" | sed 's%/[^/]\+$%%'
    ;;
    esac
done | sed -e 's%^\./%@%' -e 's%/%@%g' -e 's%.*%&@%' | \
while read listdir1; do
    A=true
    for j in $params; do
	if [[ "${j::1}" == "-" ]]; then
	    j="${j:1}"
	    j=${j//\*/[^@]*}
	    if [[ "$listdir1" != "${listdir1/@$j@/}" ]]; then
		A=false
		break
	    fi
	fi
    done
    [[ "$A" == "false" ]] && continue
    for j in $params; do
	[[ "${j::1}" == "-" ]] && continue
	j=${j//\*/[^@]*}
	if [[ "$listdir1" == "${listdir1/@$j@/}" ]]; then
	    A=false
	    break
	fi
    done
    [[ "$A" == "true" ]] && echo "$listdir1"
done | sed -e 's%^@%./%' -e 's%@$%%' -e 's%@%/%g' | \
sed -e 's%\(.*/[0-9][0-9]comm\)/.\+$%\1%' -e 's%\(.*\)/\.tags/.\+$%\1%' | \
sed 's%.*%&/%' | sort -u | sed 's%/$%%' | \
while read listdir2; do
if [[ "$findsub" == "true" ]]; then
    [[ -e "$listdir2/list.identident" ]] && echo "$listdir2/list.identident"
else
    if [[ -z "$olistdir2" ]]; then
	olistdir2="$listdir2"
	find $listdir2 -type f -name "list.identident"
    else
	if [[ ! "$listdir2" =~ ^$olistdir2/.* ]]; then
	    olistdir2="$listdir2"
	    find $listdir2 -type f -name "list.identident"
	fi
    fi
fi
done | sed 's%/list.identident$%%' | \
sed 's%.*%&/%' | sort | sed 's%/$%%' | \
while read listdir; do
if [[ "$findsub" == "true" ]]; then
    find $listdir -maxdepth 1 -type f \( ! -name "*.*ident" \)
else
    if [[ -z "$olistdir" ]]; then
	olistdir="$listdir"
	find $listdir -type f \( ! -name "*.*ident" \)
    else
	if [[ ! "$listdir" =~ ^$olistdir/.* ]]; then
	    olistdir="$listdir"
	    find $listdir -type f \( ! -name "*.*ident" \)
	fi
    fi
fi
done
}

export LC_COLLATE=C

[[ -z "$1" ]] && lsall && exit 0
[[ "$1" == "*" ]] && lsgroups && exit 0

if [[ "$1" == "-o" ]]; then
    extractor=1
    shift
else
    if [[ "$1" == "-a" ]]; then
	extractand=1
	shift
    fi
fi

[[ -z "$1" ]] && echo "Add search params" && exit 1

OIFS=$IFS
IFS=$'\n'
params_linefeed="$*"
IFS=$OIFS
#params_def="$@"

for i in $params_linefeed; do
    if [[ "${i::1}" == "-" ]]; then
	findsub=true
	break
    fi
done

if [[ -z "$extractand" ]]; then
    lsor "$params_linefeed"
else
    lsand "$params_linefeed"
fi

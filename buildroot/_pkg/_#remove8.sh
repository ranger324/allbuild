#set +e
#set -x


#rem="eudev"
#rem="zlib eudev"
[ -z "$1" ] && exit 1
##rem="$@"
OIFS="$IFS"
IFS=$'\n'
rem2="$*"
IFS="$OIFS"

rem2=`echo "$rem2" | sort -u`

#check if package exists
for i in $rem2; do
:
####
[[ ! -e .local/$i ]] && echo "No such package: $i" && exit 1
#    [[ ]] && echo "No such package: $i" && exit 1
done

cd .local
echo -n > ../.rem_cache.tmp1
echo -n > ../.rem_cache.tmp2
echo -n > ../.rem_cache.tmp1.sort
echo -n > ../.rem_cache.tmp2.sort
#echo "Getting dependencies..."

while true; do
if test -s ../.rem_cache.tmp1.sort; then
    cp ../.rem_cache.tmp1.sort ../.rem_cache.tmp1
    for i in `cut -d / -f 1 ../.rem_cache.tmp1.sort | sort -u`; do
	ls -d */.depends/$i >> ../.rem_cache.tmp1 2> /dev/null
    done
    sort -u ../.rem_cache.tmp1 > ../.rem_cache.tmp1.sort
else
    for i in $rem2; do
	ls -d */.depends/$i >> ../.rem_cache.tmp1 2> /dev/null
    done
    if ! test -s ../.rem_cache.tmp1; then
	no_deps_to_remove=1
	break
    fi
    sort -u ../.rem_cache.tmp1 > ../.rem_cache.tmp1.sort
fi
if cmp ../.rem_cache.tmp1.sort ../.rem_cache.tmp2.sort > /dev/null 2>&1; then
    break
else
    cp ../.rem_cache.tmp1.sort ../.rem_cache.tmp2.sort
fi
done
cd ..

if [ "$no_deps_to_remove" = 1 ]; then
    for i in $rem2; do
	echo "$i"
    done
    exit 0
fi

OPKG=
DEPP=
while read line; do
    PKG=${line%%/*}
    DEP=${line##*/}
    if [[ "$OPKG" != "$PKG" ]]; then
	if [[ -z "$OPKG" ]]; then
	    DEPP="$DEP"
	else
	    echo "$OPKG/.depends/$DEPP"
	    DEPP="$DEP"
	fi
	OPKG="$PKG"
    else
	[[ -z "$DEPP" ]] && DEPP="$DEP" || DEPP="$DEPP $DEP"
    fi
done < .rem_cache.tmp1.sort > .rem_cache.tmp1.sort4
##!notice! check we went through while :[[]]
[[ ! -z "$PKG" ]] && echo "$PKG/.depends/$DEPP" >> .rem_cache.tmp1.sort4


cut -d / -f 1 .rem_cache.tmp1.sort | sort -u > .rem_cache.tmp1.sort1
echo "$rem2" > .rem_cache.tmp1.sort5
comm -23 --nocheck-order .rem_cache.tmp1.sort5 .rem_cache.tmp1.sort1 | sed 's%.*%&/.depends/%' > .rem_cache.tmp1.sort2
cat .rem_cache.tmp1.sort2 .rem_cache.tmp1.sort4 > .rem_cache.tmp1.sort3


num=0
declare -g -a list
while read line; do
    list[$num]="$line"
    let num++
done < .rem_cache.tmp1.sort3

processed="@"
orig_maxindex=$(( ${#list[@]} - 1 ))
num=0
exiterr=
cyclenum=0
while (( ${#list[@]} != 0 )); do
####
    if [[ -z "${list[$num]}" ]]; then
	if [[ "$num" -lt "$orig_maxindex" ]]; then
	    num=$(( "$num" + 1 ))
	else
	    num=0
##
	    if [[ "$cyclenum" == 0 ]]; then
		exiterr=1
		break
	    else
		cyclenum=0
	    fi
##
	fi
	continue
    fi
####
    name="${list[$num]%%/*}"
    depends="${list[$num]##*/}"
    deperror=
    for i in $depends; do
	#check depend
	[[ "$name" == "$i" ]] && echo "Package depends on itself: $name" && exit 1
	if [[ "${processed}" == "${processed/@$i@/}" ]]; then
	    deperror=1
	    break
	fi
    done
    if [[ -z "$deperror" ]]; then
	processed="${processed}${name}@"
	unset list[$num]
##
	(( cyclenum++ ))
##
    fi
####
    if [[ "$num" -lt "$orig_maxindex" ]]; then
	num=$(( "$num" + 1 ))
    else
	num=0
##
	if [[ "$cyclenum" == 0 ]]; then
	    exiterr=1
	    break
	else
	    cyclenum=0
	fi
##
    fi
####
done

verbose=0

if [[ "$exiterr" == 1 ]]; then
    echo "Circular dependency!"
    if [[ "$verbose" == 1 ]]; then
	num=0
	while [[ ${num} -le ${orig_maxindex} ]]; do
	    if [[ -z "${list[$num]}" ]]; then
		num=$(( "$num" + 1 ))
	    else
		echo "${list[$num]}"
		num=$(( "$num" + 1 ))
	    fi
	done
    fi
    exit 1
else
    len=$(( ${#processed} - 1 ))
    processed="${processed::$len}"
    reverse=`echo "${processed}" | tr '@' '\n' | tac`
    echo "$reverse"
fi

exit 0

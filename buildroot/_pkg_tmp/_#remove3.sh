#set +e


#rem="eudev"
rem="zlib eudev"
#[ -z "$1" ] && exit 1
#rem="$@"

#check if package exists
cd .local
echo -n > ../.rem_cache.tmp1
echo -n > ../.rem_cache.tmp2
echo -n > ../.rem_cache.tmp1.sort
echo -n > ../.rem_cache.tmp2.sort
#echo "Getting dependencies..."
LS=`ls */depends`
while true; do
if test -s ../.rem_cache.tmp1.sort; then
    cp ../.rem_cache.tmp1.sort ../.rem_cache.tmp1
    for i in `cut -d / -f 1 ../.rem_cache.tmp1.sort | sort -u`; do
	echo "$LS" | xargs grep "^$i$" >> ../.rem_cache.tmp1
    done
    sort -u ../.rem_cache.tmp1 > ../.rem_cache.tmp1.sort
else
    for i in $rem; do
	echo "$LS" | xargs grep "^$i$" >> ../.rem_cache.tmp1
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
###remove collected
###remove selected
cd ..


OPKG=
DEPP=
while read line; do
    PKG=${line%%/*}
    DEP=${line##*:}
    if [ "$OPKG" != "$PKG" ]; then
	if [ -z "$OPKG" ]; then
	    DEPP="$DEP"
	else
	    echo "$OPKG/depends:$DEPP"
	    DEPP="$DEP"
	fi
	OPKG="$PKG"
    else
	[ -z "$DEPP" ] && DEPP="$DEP" || DEPP="$DEPP $DEP"
    fi
done < .rem_cache.tmp1.sort > .rem_cache.tmp1.sort4
echo "$PKG/depends:$DEPP" >> .rem_cache.tmp1.sort4


cut -d / -f 1 .rem_cache.tmp1.sort | sort -u > .rem_cache.tmp1.sort1
cut -d : -f 2 .rem_cache.tmp1.sort | sort -u > .rem_cache.tmp1.sort2
cat .rem_cache.tmp1.sort1 .rem_cache.tmp1.sort2 | sort -u > .rem_cache.tmp1.sort3
DIFF=`comm -13 --nocheck-order .rem_cache.tmp1.sort1 .rem_cache.tmp1.sort3`
for i in $DIFF; do
    echo "$i/depends:" >> .rem_cache.tmp1.sort4
done


num=0
declare -g -a list
while read line; do
list[$num]="$line"
let num++
done < .rem_cache.tmp1.sort4

processed=
orig_maxindex=$(( ${#list[@]} - 1 ))
num=0
while (( ${#list[@]} != 0 )); do

    if [[ -z "${list[$num]}" ]]; then
	[[ "$num" -lt "$orig_maxindex" ]] && num=$(( "$num" + 1 )) || num=0
	continue
    fi
    name="${list[$num]%%/*}"
    depends="${list[$num]#*:}"
    deperror=
    for i in $depends; do
	[[ "$name" == "$i" ]] && echo "$i----$i----$i"
	if ! echo "$processed" | grep -q "^$i$"; then
	    deperror=1
	    break
	fi
    done
    if [[ -z "$deperror" ]]; then
	[[ -z "$processed" ]] && processed="$name" || processed=`echo -ne "$processed\n$name"`
	unset list[$num]
    fi

    [[ "$num" -lt "$orig_maxindex" ]] && num=$(( $num + 1 )) || num=0
done

reverse=`echo "$processed" | tac`

echo "$reverse"
#exit 0

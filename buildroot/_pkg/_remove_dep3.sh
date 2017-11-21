#set +e


[ -z "$1" ] && exit 1
rem="$@"

#check if package exists

echo -n > .rem_cache.tmp1
echo -n > .rem_cache.tmp2
echo -n > .rem_cache.tmp1.sort
echo -n > .rem_cache.tmp2.sort
#echo "Getting dependencies..."


LS=`ls */depends`

while true; do
if test -s .rem_cache.tmp1.sort; then
    cp .rem_cache.tmp1.sort .rem_cache.tmp1
    for i in `rev .rem_cache.tmp1.sort | cut -d - -f 3- | rev`; do
	echo "$LS" | xargs grep "^$i$" | cut -d / -f 1 >> .rem_cache.tmp1
    done
    sort -u .rem_cache.tmp1 > .rem_cache.tmp1.sort
else
    for i in $rem; do
	echo "$LS" | xargs grep "^$i$" | cut -d / -f 1 >> .rem_cache.tmp1
    done
    if ! test -s .rem_cache.tmp1; then
	no_deps_to_remove=1
	break
    fi
    sort -u .rem_cache.tmp1 > .rem_cache.tmp1.sort
fi
if cmp .rem_cache.tmp1.sort .rem_cache.tmp2.sort > /dev/null 2>&1; then
    break
else
    cp .rem_cache.tmp1.sort .rem_cache.tmp2.sort
fi
done

###remove collected
###remove selected

if [ "$no_deps_to_remove" = 1 ]; then
    for i in $rem; do
	echo "$i"
    done
    exit 0
fi



rev .rem_cache.tmp1.sort | cut -d - -f 3- | rev > .rem_cache.tmp2.sort

for i in $rem; do
    echo "$i" >> .rem_cache.tmp2.sort
done
sort -u .rem_cache.tmp2.sort > .rem_cache.tmp1.sort



ls */depend@ | xargs grep "." > .name_cache
find . -name depend@ -type f -size 0 | sed -e 's%^./%%' -e 's%.*%&:%' >> .name_cache
sort .name_cache | sed 's%\(.*\)/\(.*\)%\1/\1/\2%' | rev | \
	sed 's%\(.*\)/\([0-9]\+\)-\([0-9a-z.]\+\)-\(.*\)%\1/ \2 \3 \4%'| rev > .name_cache2

deps=`cat .rem_cache.tmp1.sort`
echo -n > .name_cache2.tmp1
echo -n > .name_cache2.tmp2
echo -n > .name_cache2.tmp1.sort
echo -n > .name_cache2.tmp2.sort
#echo "Getting dependencies..."
while true; do
if test -s .name_cache2.tmp1.sort; then
    cp .name_cache2.tmp1.sort .name_cache2.tmp1
    for i in `cut -d / -f 2 .name_cache2.tmp1.sort | xargs -i cat {}/depends | sort -u`; do
	grep "^$i " .name_cache2 >> .name_cache2.tmp1
	[ $? != 0 ] && echo "$i not found" && exit 1
    done
    sort -u .name_cache2.tmp1 > .name_cache2.tmp1.sort
else
    for i in $deps; do
	grep "^$i " .name_cache2 >> .name_cache2.tmp1
	[ $? != 0 ] && echo "$i not found" && exit 1
    done
    sort -u .name_cache2.tmp1 > .name_cache2.tmp1.sort
fi
if cmp .name_cache2.tmp1.sort .name_cache2.tmp2.sort > /dev/null 2>&1; then
    break
else
    cp .name_cache2.tmp1.sort .name_cache2.tmp2.sort
fi
done


num=0
declare -g -a list
while read line; do
list[$num]="$line"
let num++
done < .name_cache2.tmp1.sort

processed=

orig_maxindex=$(( ${#list[@]} - 1 ))
num=0
while (( ${#list[@]} != 0 )); do
#break
    if [[ -z "${list[$num]}" ]]; then
	[[ "$num" -lt "$orig_maxindex" ]] && num=$(( "$num" + 1 )) || num=0
	continue
    fi
    name="${list[$num]%% *}"
    name_ext="${list[$num]#*/}"
    name_ext="${name_ext%/*}"
    depends="${list[$num]#*:}"
    deperror=
    for i in $depends; do
	if ! echo "$processed" | grep -q "^$i$"; then
	    deperror=1
	    break
	fi
	[[ "$name" == "$i" ]] && echo "$i----$i----$i"
    done
    if [[ -z "$deperror" ]]; then
	[[ -z "$processed" ]] && processed="$name" || processed=`echo -ne "$processed\n$name"`
	unset list[$num]
    fi

    #let num++
    [[ "$num" -lt "$orig_maxindex" ]] && num=$(( $num + 1 )) || num=0
done

reverse=`echo "$processed" | tac`

#echo "$reverse"
#exit 0

num2=0
for i in $rem; do
    num=`echo "$reverse" | grep -n "^$i$" | cut -d : -f 1`
    [[ "$num" -gt "$num2" ]] && num2="$num"
done

echo "$reverse" | head -n "$num2" | \
while read line; do
    grep -q "^$line$" .rem_cache.tmp1.sort && echo "$line"
done
# | \
#while read pkg; do
#    (cd /dest3/.local; echo $pkg; rm -rf $(readlink $pkg); rm $pkg)
#done

#set +e

num=0
declare -g -a list
while read line; do
list[$num]="$line"
let num++
done < .name_cache2.tmp1.sort

#wc -l .name_cache2.tmp1.sort
#echo ${#list[@]}

#for (( i=0; i<${#list[@]}; i++)); do
#echo "${list[$i]%% *}"
#echo ${list[$i]#*/}
#done
#$'\n'
#exit 0

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
#echo "$name_ext"

    deperror=

    for i in `cat $name_ext/depends`; do
	[ "$name" = "$i" ] && echo "$i----$i----$i"
#echo -n "$i"
	pkgextname=`grep "^$i " .name_cache2.tmp1.sort | cut -d / -f 2`
	if [[ -e /dest3/$pkgextname ]]; then
	    :
#echo " OK"
	else
#echo " NOTOK"
	    deperror=1
	    break
	fi
    done
    if [ -z "$deperror" ]; then
	echo "$name_ext"
	cp -RpP $name_ext /dest3
	unset list[$num]
    fi

#let num++
[[ "$num" -lt "$orig_maxindex" ]] && num=$(( $num + 1 )) || num=0

done

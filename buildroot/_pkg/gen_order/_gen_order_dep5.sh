#set +e

num=0
declare -g -a list
while read -r line; do
list[$num]="$line"
let num++
done < .name_cache2.tmp1.sort

mkdir -p /dest3/.local
orig_maxindex=$(( ${#list[@]} - 1 ))
num=0
while (( ${#list[@]} != 0 )); do
#break
    if [[ -z "${list[$num]}" ]]; then
	[[ "$num" -lt "$orig_maxindex" ]] && num=$(( "$num" + 1 )) || num=0
	continue
    fi
#eg package depends on itself
#echo "#${list[$num]}#" #if [[ -z "${list[$num]}" ]] -> num=0  &  check prev localnum++
    name="${list[$num]%% *}"
    name_ext="${list[$num]#*/}"
    name_ext="${name_ext%/*}"
    depends="${list[$num]#*:}"
    deperror=
    for i in $depends; do
	[[ "$name" = "$i" ]] && echo "$i----$i----$i"
	if [[ ! -e /dest3/.local/$i ]]; then
	    deperror=1
	    break
	fi
    done
    if [[ -z "$deperror" ]]; then
	echo "$name_ext"
	cp -RpP "$name_ext" /dest3
	cp -pP .local/$name /dest3/.local
	unset list[$num]
    fi

    #let num++
    [[ "$num" -lt "$orig_maxindex" ]] && num=$(( $num + 1 )) || num=0
done

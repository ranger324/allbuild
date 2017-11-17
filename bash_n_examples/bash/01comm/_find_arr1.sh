declare -a arr
num=0
IFS=$'\n'
find -type f | while read file; do
    FILE=${file##*/}
    DIR=${file%/*}
    num=0
    unset arr

    while read line; do
	arr[num]="$line"
	(( num++ ))
    done < <(find -path "$DIR" -prune -o -type f -name "$FILE" -print)

    if [[ ! -z "$arr" ]]; then
	echo "$file"
	echo "${arr[*]/#/->}"
    fi
done

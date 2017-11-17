declare -a arr
IFS=$'\n'
find -type f | while read file; do
    FILE=${file##*/}
    DIR=${file%/*}
    A=$(find -path "$DIR" -prune -o -type f -name "$FILE" -print)
    if [[ ! -z "$A" ]]; then
	echo "$file"
	arr=(${A})
	echo "${arr[*]/#/->}"
    fi
done

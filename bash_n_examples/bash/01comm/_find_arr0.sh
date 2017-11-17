
find -type f | while read file; do
    FILE=$(basename "$file")
    DIR=$(dirname "$file")
    A=$(find -path "$DIR" -prune -o -type f -name "$FILE" -print)
    if [ ! -z "$A" ]; then
	echo "$file"
	echo "$A" | sed 's%.*%->&%'
    fi
done

find -type f -name "*.tagident" | \
while read line; do
    DIR=$(dirname "$line")
    FILE=$(basename "$line")
    echo "groupident: $FILE $DIR"
done

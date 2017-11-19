find -type f -name "*.commident" | \
while read line; do
    DIR=$(dirname "$line")
    FILE=$(basename "$line")
    GRP=$(echo "$FILE" | sed 's/\.commident$//')
    DIRUP=$(dirname "$DIR")
    [ -d "$DIRUP/$GRP" ] && echo "groupident: $FILE $DIR" || echo "Invalid groupident: $FILE $DIR"
done

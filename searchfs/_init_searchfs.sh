
find -mindepth 1 -maxdepth 1 -type d | \
while read dir; do
    gr_ident=`basename $dir`
    echo -n > "$dir/@$gr_ident@.groupident"

    find $dir -mindepth 1 -type d | \
    while read dir2; do
	N1=`basename $dir2`
	##!code! skip .tags dir
	[ "$N1" = ".tags" ] && continue
	##!code!
	N2=`dirname $dir2`
	N3=`basename $N2`
	echo -n > "$dir2/@$N1@$N3@.groupident"
    done

    find $dir -type f \( ! -name "*.*ident" \) | \
    sed 's%/[^/]\+$%%' | sort -u | \
    while read file; do
	echo -n > "$file/list.identident"
    done
done

#commidents
find -type f -name "*.commident" | \
while read line; do
    DIR=$(dirname "$line")
    FILE=$(basename "$line")
    GRP=$(echo "$FILE" | sed 's/\.commident$//')
    DIRUP=$(dirname "$DIR")
    [ -d "$DIRUP/$GRP" ] && cp "$DIRUP/$GRP"/*.groupident "$DIR" || echo "Invalid groupident: $FILE $DIR"
done

find -type f -name "*.tagident" | \
while read line; do
    DIR=$(dirname "$line")
    #GRP
    GRP=$(echo "$line" | sed 's/\.tagident$//')
    GRPTRUNC=$(basename "$GRP")
    touch "$DIR"/@$GRPTRUNC@.groupident
done

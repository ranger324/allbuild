find -mindepth 1 -maxdepth 1 -type d | sort | \
while read DIR; do
    (cd $DIR && find -type f -name "*.la") | xargs -r echo $DIR
done | \
while read DIR2 FILES; do
    (cd $DIR2 && grep -q "/root/\|/sysroot/" $FILES) && echo $DIR2
done

find -type l -printf "%P\n" -o -type f -printf "%P\n" | \
while read file; do
    FW=$(basename $file)
    A=$(grep "^$FW$\|/$FW$" fw.lst)
    [ ! -z "$A" ] && echo "file     : $file" && echo "$A" | sed "s%.*%needed_fw: &%"
done

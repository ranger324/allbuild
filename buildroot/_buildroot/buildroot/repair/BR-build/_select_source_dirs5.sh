sh _find_files_in_dirs.sh -n la | \
while read DIR2 FILES; do
    (cd $DIR2 && grep -q "/sysroot/" $FILES) && echo $DIR2
done

sh _find_files_in_dirs.sh -n la | \
while read DIR2 FILES; do
    (cd $DIR2 && grep -Hn "/sysroot/" $FILES)
done

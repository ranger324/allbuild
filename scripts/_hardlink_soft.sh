LC_COLLATE=C
declare -A filefirst
_findhardlink | \
while read -r inode file; do
    tmp="${file//[^\/]/}"
    numslash="${#tmp}"
    echo "$inode $numslash $file"
done | sort -k 1n -k 2n -k 3 | \
while read -r inode depth file; do
    if [ -z "${filefirst[$inode]}" ]; then
	filefirst[$inode]="$file"
    else
	ln -snfr "${filefirst[$inode]}" "$file"
    fi
done

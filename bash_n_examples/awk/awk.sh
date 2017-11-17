
echo "|| Package: file-123-123.tbz" | awk -f filelist.awk

#^\|\|[[:blank:]]+Package:[[:blank:]]+.*-[[:alnum:]_]+-[[:alnum:]_.]+\.t[blxg]z$

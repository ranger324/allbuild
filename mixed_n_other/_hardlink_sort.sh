_findhardlink | sed 's%\(.*\) \([0-9]\+\)$%\1#\2%' | sort -n -k 2 -t '#'

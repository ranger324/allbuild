cd package
_findtime -b 5 | while read A B C; do echo "$C" | sed -e 's%^\./%%' -e 's%/.*$%%'; done | sort -u

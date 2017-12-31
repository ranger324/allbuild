[ "$1" = "-d" ] && fdate=1
PRUNEPATHS='-path ./_scripts -o -path ./dl -o -path ./output'
if [ "$fdate" = 1 ]; then
    find \( $PRUNEPATHS \) -prune -o -type f -printf "%Ty%Tm%Td %p\n" | sort -n -r
else
    find \( $PRUNEPATHS \) -prune -o -type f -printf "%T@ %p\n" | sort -n -r
fi

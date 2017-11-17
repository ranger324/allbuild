[ -z "$1" ] && exit 1
FILE="$3"
PATT="$1"
LINE="$2"
insertline()
{
    NUM1=`grep -n "$1" "$3" | cut -d : -f 1 | head -n 1`
    NUM2=`wc -l "$3" | cut -d " " -f 1`
    sed -n 1,${NUM1}p "$3"
    NUM1=`expr $NUM1 + 1`
    echo "$2"
    sed -n ${NUM1},${NUM2}p "$3"
}

insertline "$PATT" "$LINE" "$FILE"

#sed '/pattern/a"line to insert"' file.txt

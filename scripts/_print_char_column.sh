
FILE=$1
COLL=$2
COLL=$(expr $COLL - 1)
IFS=$'\n'
cat $FILE | \
while read -r line; do
    echo "${line:$COLL}"
done

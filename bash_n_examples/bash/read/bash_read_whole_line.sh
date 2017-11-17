set -f
IFS=$'\n'
cat a | \
while read -r line; do
    LEN="${#line}"
    echo $LEN
    echo "\"$line\""
done

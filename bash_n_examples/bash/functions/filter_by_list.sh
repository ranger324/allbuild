
while read listdir1; do
    A=true
    for j in $params; do
	j=${j//\*/[^@]*}
	if ! echo "$listdir1" | grep -q "@$j@"; then
	    A=false
	    break
	fi
    done
    [ "$A" = "true" ] && echo "$listdir1"
done

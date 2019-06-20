#text and script
[ "$1" = "-t" ] && text=1

find -type f | \
while read file; do
    output=`file $file`
    if [ $text ]; then
	if echo "$output" | grep -q "POSIX shell script\|ASCII text"; then
	    echo $file
	fi
    else
	if echo "$output" | grep -q "POSIX shell script"; then
	    echo $file
	fi
    fi
done

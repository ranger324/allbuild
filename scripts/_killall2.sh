
for i in /proc/[0-9]*/exe; do
    if LNK=$(readlink $i 2> /dev/null); then
	A=${i%/exe}
	B=${A##*/}
	echo "$LNK"
    fi
done

find -mindepth 2 -name "*.mk" | \
while read mkfile; do
    grep -n "[^[:space:]][\]$" $mkfile | \
    while read -r line; do
	LN="$(echo "$line" | cut -d : -f 1)"
	LINE="$(echo "$line" | cut -d : -f 2- | tr -d '\' 2> /dev/null)"
	head -n $(expr $LN - 1) $mkfile > ${mkfile}.tmp
	echo "$LINE \\" >> ${mkfile}.tmp
	tail -n +$(expr $LN + 1) $mkfile >> ${mkfile}.tmp
	mv ${mkfile}.tmp ${mkfile}
    done
done

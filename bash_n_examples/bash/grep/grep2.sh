grep -H #print filename
NUM=1
echo "$NUM" | grep "[^[:digit:]]"
echo "$NUM" | grep -x "[[:digit:]]\+"

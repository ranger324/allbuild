
myarray=('a a' 'vv' 'vvv' 'b b' 'c c')
echo "${!myarray[@]}"
declare -g -A myarray_index
for i in "${!myarray[@]}"; do
    eval myarray_index["${myarray[$i]}"]=$i
done

member="vv"

# the "|| echo NOT FOUND" below is needed if you're using "set -e"
test "${myarray_index[$member]}" && echo FOUND || echo NOT FOUND
member="c c"
test "${myarray_index[$member]}" && echo FOUND || echo NOT FOUND
test "${myarray_index[a a]}" && echo FOUND || echo NOT FOUND
echo "${myarray_index[$member]}"
echo "${myarray_index[a a]}"
echo "${myarray_index[a]}"

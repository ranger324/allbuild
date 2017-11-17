A=("a" "b" "c")
echo ${!A[@]}
echo "##"
for i in ${!A[@]}; do
    echo "${A[i]}"
done
echo "##"
unset A[1]

for i in ${!A[@]}; do
    echo "${A[i]}"
done

echo ${!A[@]}

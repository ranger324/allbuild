y=( 'odd[j]' 'even[j++]' )
printf 'input%s\n' {1..10} | \
{
mapfile -t -c 1 -C 'printf -v "${y[${#x[@]} % 2]}" -- "%.sprefix %s"' x
printf '%s\n' "${odd[@]}" '' "${even[@]}"
}

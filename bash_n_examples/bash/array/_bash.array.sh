A=(1 2 3)
IFS=$'\n' ; echo "${A[*]}"
#IFS=$'\n' ; echo "${A[*]}" > ____asd
IFS=$'\n'
readarray -t lines  < /etc/profile
echo "${lines[0]}"
echo "${lines[1]}"
#IFS=$'\n'; echo "${lines[*]}" > ____asd
IFS=$'\n'; echo "${lines[*]}"
#${!array[@]} ${!array[*]}  ?
echo "${!lines[@]}"
unset lines[1]
echo "${!lines[@]}"


    local username uid group gid passwd home shell groups comment
    local line
    local -a ENTRIES

    while read line; do
        ENTRIES+=( "${line}" )
    done < <( sed -r -e 's/#.*//; /^[[:space:]]*$/d;' "${USERS_TABLE}" )

    for line in "${ENTRIES[@]}"; do
        read username uid group gid passwd home shell groups comment <<<"${line}"
        [ ${gid} -ge 0 ] || continue    # Automatic gid
        echo add_one_group "${group}" "${gid}"
    done

USERS_TABLE=_users_table.txt
[ ! -z "$1" ] && USERS_TABLE="$1"
main() {
    local username uid group gid passwd home shell groups comment
    local line
    local -a ENTRIES

    sed -r -e 's/#.*//; /^[[:space:]]*$/d;' "${USERS_TABLE}" > "${USERS_TABLE}.x"
    # Read in all the file in memory, exclude empty lines and comments
    while read line; do
        ENTRIES+=( "${line}" )
    done < "${USERS_TABLE}.x"

    # We first create groups whose gid is not -1, and then we create groups
    # whose gid is -1 (automatic), so that, if a group is defined both with
    # a specified gid and an automatic gid, we ensure the specified gid is
    # used, rather than a different automatic gid is computed.

    # First, create all the main groups which gid is *not* automatic
    for line in "${ENTRIES[@]}"; do
        read username uid group gid passwd home shell groups comment <<<"${line}"
        [ ${gid} -ge 0 ] || continue    # Automatic gid
        echo add_one_group "${group}" "${gid}"
    done

    # Then, create all the main groups which gid *is* automatic
    for line in "${ENTRIES[@]}"; do
        read username uid group gid passwd home shell groups comment <<<"${line}"
        [ ${gid} -eq -1 ] || continue    # Non-automatic gid
        echo add_one_group "${group}" "${gid}"
    done

    # Then, create all the additional groups
    # If any additional group is already a main group, we should use
    # the gid of that main group; otherwise, we can use any gid
    for line in "${ENTRIES[@]}"; do
        read username uid group gid passwd home shell groups comment <<<"${line}"
        if [ "${groups}" != "-" ]; then
            for g in ${groups//,/ }; do
                echo add_one_group "${g}" -1
            done
        fi
    done

    # When adding users, we do as for groups, in case two packages create
    # the same user, one with an automatic uid, the other with a specified
    # uid, to ensure the specified uid is used, rather than an incompatible
    # uid be generated.

    # Now, add users whose uid is *not* automatic
    for line in "${ENTRIES[@]}"; do
        read username uid group gid passwd home shell groups comment <<<"${line}"
        [ "${username}" != "-" ] || continue # Magic string to skip user creation
        [ ${uid} -ge 0         ] || continue # Automatic uid
        echo add_one_user "${username}" "${uid}" "${group}" "${gid}" "${passwd}" \
                     "${home}" "${shell}" "${groups}" "${comment}"
    done

    # Finally, add users whose uid *is* automatic
    for line in "${ENTRIES[@]}"; do
        read username uid group gid passwd home shell groups comment <<<"${line}"
        [ "${username}" != "-" ] || continue # Magic string to skip user creation
        [ ${uid} -eq -1        ] || continue # Non-automatic uid
        echo add_one_user "${username}" "${uid}" "${group}" "${gid}" "${passwd}" \
                     "${home}" "${shell}" "${groups}" "${comment}"
    done
}

#----------------------------------------------------------------------------
main "${@}"

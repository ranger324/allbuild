#!/usr/bin/env bash

showRecord() {
    printf 'key[%d] = %d, %d\n' "$1" "${vals[@]:keys[$1]*2:2}"
}

parseRecords() {
    trap 'unset -f func' RETURN
    func() {
        local x
        IFS=: read -r tmp x && ((keys[x]=n++))
#        IFS=: read -r tmp x
#        ((keys[x]=n++))
    }
    local n

    func
    mapfile -t -c 2 -C func "$1"
    eval "$1"'=("${'"$1"'[@]##*:}")' # Return the array with some modification
    #vals=("${vals[@]##*:}")
}

main() {
    local -a keys vals
    parseRecords vals
    showRecord "$1"
echo "${vals[@]}"
echo "${keys[@]}"
}

main "$1" << "EOF"
fabric.domain:123
routex:1
routey:2
fabric.domain:321
routex:6
routey:4
fabric.domain:111
routex:5
routey:8
EOF

#if ...
#    main "$1" <<-"EOF"
#    fabric.domain:123
#    routex:1
#    routey:2
#    fabric.domain:321
#    routex:6
#    routey:4
#    EOF
#fi

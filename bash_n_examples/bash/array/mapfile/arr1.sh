#!/usr/bin/env bash

parseRecords() {
    local x tmp
    IFS=: read -r tmp x
    keys[x]=$tmp
}

main() {
    local -a keys vals
    parseRecords

##
    mapfile -tc2 -C parseRecords vals
    echo "${vals[@]}"
    echo "${keys[@]}"
}

main << "EOF"
fabric.domain:123
routex:1
routey:2
fabric.domain:321
routex:6
routey:4
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

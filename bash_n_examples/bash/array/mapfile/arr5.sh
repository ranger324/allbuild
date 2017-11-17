#!/usr/bin/env bash

func() {
    local tmp x
    IFS=: read -r tmp x && echo "#$tmp#$x#"
    #being run after last mapfile read & before value assign
}

main() {
    local -a line
    #read first
    func
    #read all+function reads line - making it missing from array - after two array assign
    mapfile -t -c 2 -C func line
    echo "${line[@]}"
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

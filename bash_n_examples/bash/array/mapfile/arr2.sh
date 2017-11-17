#!/usr/bin/env bash

main() {
    local tmp x
    IFS=: read -r tmp x
    echo "$tmp $x"
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

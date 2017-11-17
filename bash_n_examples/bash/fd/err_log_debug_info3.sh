#!/bin/bash

log() {
    echo $* >&3
}
info() {
    echo $* >&4
}
err() {
    echo $* >&2
}
debug() {
    echo $* >&5
}

VERBOSE=1

while [[ $# -gt 0 ]]; do
    ARG=$1
    shift
    case $ARG in
        "-vv")
            VERBOSE=3
        ;;
        "-v")
            VERBOSE=2
        ;;
        "-q")
            VERBOSE=0
        ;;
        # More flags
        *)
        echo -n
        # Linear args
        ;;
    esac
done

for i in 1 2 3; do
    fd=$(expr 2 + $i)
    if [[ $VERBOSE -ge $i ]]; then
        eval "exec $fd>&1"
    else
        eval "exec $fd> /dev/null"
    fi
done

err "This will _always_ show up."
log "This is normally displayed, but can be prevented with -q"
info "This will only show up if -v is passed"
debug "This will show up for -vv"

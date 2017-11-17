getpipe2_retval_exec()
{
    local ret
    exec 4>&1
    ret=`((($1; printf "$?" >&3) | $2) >&4) 3>&1`
    exec 4>&-
    return $ret
}

getpipe3_retval_exec()
{
    local ret
    exec 4>&1
    ret=`((($1; printf "$?" >&3) | $2 | $3) >&4) 3>&1`
    exec 4>&-
    return $ret
}

getpipe_retval_exec()
{
    local ret
    exec 4>&1
    ret=`((($1; printf "$?" >&3) | eval $2) >&4) 3>&1`
    exec 4>&-
    return $ret
}

getpipe2_retval_return()
{
    (((($1; printf "$?" >&3) | $2 >&4) 3>&1) | (read ret; exit $ret)) 4>&1
    return $?
}

getpipe3_retval_return()
{
    (((($1; printf "$?" >&3) | $2 | $3 >&4) 3>&1) | (read ret; exit $ret)) 4>&1
    return $?
}

getpipe_retval_return()
{
    (((($1; printf "$?" >&3) | eval $2 >&4) 3>&1) | (read ret; exit $ret)) 4>&1
    return $?
}

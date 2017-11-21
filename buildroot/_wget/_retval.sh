
[ -z "$WGETOUT" ] && WGETOUT=1

WGET_CONNOPTS="--passive-ftp -t 1 --timeout=5"
WGET_OPTS="-q --progress=dot --show-progress"



bartext="$(printf "%-.30s" "$FILE")"
bar=`expr $(stty size | cut -d " " -f 2) - ${#bartext} - 1 - 2 - 4 - 1 - 1`

wgetcmd()
{
    wget $WGET_OPTS $WGET_CONNOPTS -O - $URL 2>&1 > $FILE
}

process_wget_sed()
{
    sed -u -n -e 's/%.*//' -e 's/.* //p'
}

process_wget_awk()
{
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { match($0, / ([0-9][0-9]?[0-9]?)%/, arr); print arr[1] }'
}

printpercent()
{
while read perc; do
if [ "$dperc" != "$perc" ] && [ ! -z "$perc" ] && [ "$bar" -gt 0 ]; then
    barp=$(($bar * $perc / 100))
    barend=$(($bar - $barp))
    printf "\r%-$((${#bartext} + 1))s" "$bartext"
    printf "["
    for i in $(seq 1 $barp); do
	printf "#"
    done
    for i in $(seq 1 $barend); do
	printf " "
    done
    printf "] "
    printf "%4s" "${perc}%"
    dperc=$perc
fi
done
}

printfull()
{
if [ "$bar" -gt 0 ]; then
    printf "\r%-$((${#bartext} + 1))s" "$bartext"
    printf "["
    for i in $(seq 1 $bar); do
	printf "#"
    done
    printf "] "
    printf "%4s" "100%"
    printf "\n"
fi
}

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

case "$WGETOUT" in
1)
    getpipe_retval_return wgetcmd "process_wget_sed | printpercent"
    retval=$?
    if [ "$retval" = "0" ]; then
        printfull
    fi
;;
2)
    WGET_OPTS="-q --progress=bar --show-progress"
    wgetcmd
    retval=$?
;;
3)
    DIALOGRC=sourcemage.rc
    export DIALOGRC
    getpipe_retval_return wgetcmd "process_wget_sed | dialog --title \"Downloading...\" --gauge \"$FILE\" 6 75"
    retval=$?
;;
4)
    echo $FILE
    wgetcmd
    retval=$?
    echo
    echo
;;
esac

exit $retval

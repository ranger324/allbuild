[ "$1" = "-pid" ] && printpid=1
cd /proc
if [ "$printpid" = 1 ]; then
    ls -l [0-9]*/exe 2> /dev/null | sed -n 's%^.* \([0-9]\+\)/exe -> \(.*\)$%\1 \2%p'
else
    ls -l [0-9]*/exe 2> /dev/null | sed -n 's%^.* -> \(.*\)$%\1%p'
fi

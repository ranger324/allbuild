#set -x
[ -z "$1" ] && exit 1
setparam=1
while true; do
parm="$1"
if [ "$parm" = "-c" ]; then
    close_end=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-e" ]; then
    exit_nomatch=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-x" ]; then
    longest=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-q" ]; then
    dont_print_file=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-2" ]; then
    find_next_line=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-s" ]; then
    start_line_num=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-1" ]; then
    print_wo_last=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-z" ]; then
    print_till_end=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-i" ]; then
    print_inner=1
    shift
    continue
else
    setparam=
fi
if [ "$parm" = "-n" ]; then
    print_num=1
    shift
    continue
else
    setparam=
fi
if [ -z "$setparam" ]; then
    if [ "$parm" != "$(echo "$parm" | sed 's%^-%%')" ]; then
	echo "No such param"
	exit 1
    else
	break
    fi
fi
done
echo "$@"

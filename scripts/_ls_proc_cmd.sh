catproc()
{
    DPROC="$1"
    VAR=$(cat "$DPROC" 2> /dev/null | tr '\0' ' ')
    retval=${PIPESTATUS[0]}
    [ "$retval" = 0 -a ! -z "$VAR" ] && echo "$DPROC $VAR"
}
cd /proc
ls [0-9]*/cmdline | \
while read line; do
    catproc "$line"
done

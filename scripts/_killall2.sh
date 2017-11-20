#exclude pid
except=$1
for i in /proc/[0-9]*/exe; do
    if LNK=$(readlink $i 2> /dev/null); then
        A=${i%/exe}
        B=${A##*/}
        LPID=`ps -o ppid= -p $$`
        LPID=${LPID// /}
        if [ -z "$except" ]; then
	    [ $B != 1 -a $B != $$ -a $B != $LPID ] && kill $B
        else
	    [ $B != 1 -a $B != $$ -a $B != $LPID -a $B != $except ] && kill $B
        fi
    fi
done

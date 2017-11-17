LPPID=`ps -o ppid= -p $$`
LPPID=${LPPID// /}
PLPPID=`ps -o ppid= -p $LPPID`
PLPPID=${PLPPID// /}

for i in /proc/[0-9]*/exe; do
    if LNK=$(readlink $i 2> /dev/null); then
	A=${i%/exe}
	B=${A##*/}
	[ $B != 1 -a $B != $$ -a $B != $LPPID -a $B != $PLPPID ] && kill $B
    fi
done

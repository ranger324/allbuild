[ "$1" = "-printenv" ] && prenv=1

for i in /proc/[0-9]*/exe; do
    if LNK=$(readlink $i 2> /dev/null); then
        A=${i%/exe}
        echo -n "${A##*/} "
        echo "$LNK"
        if [ ! -z "$prenv" ]; then
	    cat $A/environ | tr "\0" "\n" | xargs -r -i bash -c '[[ "{}" =~ ^.*=.*$ ]] && echo "\"{}\""'
        fi
    fi
done


[ ! -z "$1" ] && tgzparm=1 && tgz="$@"

export LC_COLLATE=C

if ! [ $tgzparm ]; then
    for i in *.tar.gz; do
	FILES=$(tar tzf "$i" --wildcards "etc/*" 2> /dev/null | sed 's%.*%-&%')
	[ ! -z "$FILES" ] && echo "$i" && echo "$FILES" | grep -v "/$" | sort
    done
else
    for i in $tgz; do
	FILES=$(tar tzf "$i" --wildcards "etc/*" 2> /dev/null | sed 's%.*%-&%')
	[ ! -z "$FILES" ] && echo "$i" && echo "$FILES" | grep -v "/$" | sort
    done
fi

#check /etc/group /etc/passwd
ls _scripts/*.install 2> /dev/null | xargs grep "^adduser " | \
    sed -n 's%.*\.install:\(adduser\)[[:space:]]\+.*[[:space:]]\+\(-u[[:space:]]\+[0-9]\+\)[[:space:]]\+[^a-zA-Z0-9_]*\([a-zA-Z0-9_]\+\) 2> /dev/null$%\1 \2 \3%p'

ls _scripts/*.install 2> /dev/null | xargs grep "^addgroup " | \
    sed -n 's%.*\.install:\(addgroup\)[[:space:]]\+\(-g[[:space:]]\+[0-9]\+\)[[:space:]]\+[^a-zA-Z0-9_]*\([a-zA-Z0-9_]\+\) 2> /dev/null$%\1 \2 \3%p'

[ -z "$1" ] && exit 1
LIST=`ls -a | grep -v "^.$\|^..$\|^.git$\|^_make_git_tar.sh$"`
tar czf $1.tar.gz $LIST

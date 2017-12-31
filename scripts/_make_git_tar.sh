[ -z "$1" ] && exit 1
LIST=`ls -A | grep -v "^\.git$\|^_make_git_tar\.sh$"`
tar czf $1.tar.gz $LIST

#ls -A | grep -v "^\.git$\|^_make_git_tar\.sh$" | xargs -r tar czf $1.tar.gz

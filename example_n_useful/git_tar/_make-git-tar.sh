LIST=`ls -a | grep -v "^.$\|^..$\|^.git$\|^_make-git-tar.sh$"`
tar czf $1.tar.gz $LIST

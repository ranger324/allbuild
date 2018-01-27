[ -z "$1" ] && exit 1
#--transform="s%^%$1/%S"
#--transform="flags=S;s%^%$1/%"

#LIST=`ls -A | grep -v "^\.git$\|^_make_git_tar_dir\.sh$"`
#tar czf $1.tar.gz --transform="flags=S;s%^%$1/%" $LIST

ls -A | grep -v "^\.git$\|^_make_git_tar_dir\.sh$" | xargs -r tar czf $1.tar.gz --transform="flags=S;s%^%$1/%"

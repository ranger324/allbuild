exts=".tar.gz .tar.bz2 .tar.xz .tar.lz .tgz .zip"
echoext()
{
    for z in $exts; do
	echo -n "-name *$z -o "
    done | sed 's/[[:space:]]\+-o[[:space:]]\+$//'
}

set -f
PARM=`echoext`
find $PARM

PARM="-name 'ls *'"
#eval "find $PARM"
eval find $PARM
#find -regextype posix-egrep -regex ".*\.(py|html)$"
#find -regex ".*\.\(py\|html\)$"
namepatterns+=(-o -name "*.ls")
namepatterns+=(-o -name "ls *")
namepatterns+=(-o -name "ls*")
namepatterns+=(-o -name "*ls*")
namepatterns=("${namepatterns[@]:1}")
echo "${namepatterns[@]}"
find . "${namepatterns[@]}"

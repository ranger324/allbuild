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

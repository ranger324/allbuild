##${var} review check

exts=".tar.gz .tar.bz2 .tar.xz .tar.lz .tgz .zip"
echo -n > /tmp/file2

echoext()
{
    for z in $exts; do
	echo -n "-name *$z -o "
    done | sed 's/[[:space:]]\+-o[[:space:]]\+$//'
}

set -f
PARM=`echoext`

find -mindepth 1 -type f \( $PARM \) -printf "%P\n" | sort -V | tee /tmp/file1 | \
while read line; do

if [ "$line" != "${line/\//}" ]; then
    ARCHIVE=${line##*/}
    DIR=${line%/*}
else
    ARCHIVE=${line}
    DIR=
fi

[ $ARCHIVE != ${ARCHIVE%.tar.gz} ] && EXT=".tar.gz"
[ $ARCHIVE != ${ARCHIVE%.tar.bz2} ] && EXT=".tar.bz2"
[ $ARCHIVE != ${ARCHIVE%.tar.xz} ] && EXT=".tar.xz"
[ $ARCHIVE != ${ARCHIVE%.tar.lz} ] && EXT=".tar.lz"
[ $ARCHIVE != ${ARCHIVE%.tgz} ] && EXT=".tgz"
[ $ARCHIVE != ${ARCHIVE%.zip} ] && EXT=".zip"
WO_EXT=${ARCHIVE%$EXT}


if echo $WO_EXT | grep -q "-"; then

if [ "${WO_EXT}" != "${WO_EXT%-rc*}" ]; then
    WO_RC=${WO_EXT%-rc*}
    RC=${WO_EXT#$WO_RC}
    NAME=${WO_RC%-*}
    VER=${WO_RC#${NAME}-}
else
    NAME=${WO_EXT%-*}
    VER=${WO_EXT#${NAME}-}
    [ "$VER" = "master" ] && VER=0
fi

else
    NAME=$WO_EXT
    VER=0
fi

if [ "$VER" != 0 ]; then
if [ -z "$DIR" ]; then
    echo "$NAME $VER $EXT" >> /tmp/file2
else
    echo "$NAME $VER $EXT $DIR" >> /tmp/file2
fi
fi
done

sort -V -k 2 -r /tmp/file2 > /tmp/file3
#sort -V -k 2,2 -r /tmp/file2 > /tmp/file3

DONEPKGS=
cat /tmp/file3 | \
while read NAME VER EXT DIR; do
if ! echo "$DONEPKGS" | grep -q "^$NAME$"; then
    if [ -z "$DIR" ]; then
	echo "$NAME $VER $EXT"
    else
	echo "$NAME $VER $EXT $DIR"
    fi
    [ -z "$DONEPKGS" ] && DONEPKGS="$NAME" || DONEPKGS=`echo -ne "$DONEPKGS\n$NAME"`
fi
done | sort -V


[ $# != 2 ] && exit 1
GRP1=$1
GRP2=$2

ls_packages()
{
NUM=xx
pacman -Slg $(pacman -Slg) | sort -k 2 | \
while read GRPN PKGN; do
    [ $NUM = xx ] && NUM=x || NUM=xx
    [ $NUM = x ] && echo -n "$PKGN " && GRPN2=$GRPN
    [ $NUM = xx ] && echo -n "$GRPN2 " && echo $GRPN
done
}

ls_packages | grep " $GRP1 $GRP2$" | cut -d ' ' -f 1

#extract package files based on corelist file (corecore.lst)
[ -z "$1" ] && exit 1
mkdir -p $1/var/cache/pacman/pkg $1/var/lib/pacman
pacman -S -y -r $1
pacman -Sf -r $1 --cachedir $1/var/cache/pacman/pkg --noscriptlet --noconfirm `cat corecore.lst`

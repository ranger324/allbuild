GRUBDEV=$(grub-probe -t bios_hints -d $(findmnt -n -T /boot/grub | while read MNTP DEV FSTYPE OPTS; do echo $DEV; done))
#GRUBPATH="(hd0,msdos12)/boot/grub"
GRUBPATH="($GRUBDEV)/boot/grub"
#grub-mkimage -p $GRUBPATH -O i386-pc -o /boot/grub/i386-pc/core.img biosdisk part_msdos ext2
grub-mkimage -p "$GRUBPATH" -O i386-pc -o /boot/grub/i386-pc/core.img biosdisk ext2 fat part_gpt part_msdos

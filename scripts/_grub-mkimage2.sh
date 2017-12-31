#grub-mkimage -p /boot/grub -O i386-pc -o /boot/grub/i386-pc/core.img biosdisk part_msdos ext2
grub-mkimage -p /boot/grub -O i386-pc -o /boot/grub/i386-pc/core.img biosdisk ext2 fat part_gpt part_msdos

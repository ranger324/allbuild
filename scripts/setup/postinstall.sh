#! /bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin

(cd /etc/skel; find -type f | cpio -p --make-directories /root)

pwconv

while true; do
    if /root/manage/pwdialog; then
	break
    fi
done

while true; do
if NEWUSER=`dialog --clear --stdout --inputbox "Add new user - enter a username" 8 40`; then
    if [ ! -z "$NEWUSER" ]; then
	if sh /home/useradd.sh `echo "$NEWUSER" | sed 's/[[:space:]]/_/g'`; then
	    break
	fi
    fi
else
    break
fi
done

if [ ! -z "$NEWUSER" ]; then
    while true; do
    if /root/manage/pwdialog "$NEWUSER"; then
	break
    fi
    done
fi

/root/setup/setconsolefont
/root/setup/setlocale
/root/setup/settimezone
/root/setup/setrunlevel

if [ -e /etc/X11/xinit.d ]; then
    /root/setup/setdefsession
    /root/setup/setxmonitor
    /root/setup/setxresolution
    /root/setup/setxorgdriver
    /root/setup/setxorgkeymap
fi

clear

#grub-mkdevicemap --no-floppy
grub-mkconfig > /boot/grub/grub.cfg
/root/setup/installgrub

echo "Making post install tasks..."
for i in /var/lib/pacman/local/*/install; do
    if grep -q "post_install" $i; then
	source $i
	post_install > /dev/null 2>&1
    fi
done

#echo "set grub-pc/install_devices /dev/sda" | debconf-communicate
echo "set grub-pc/install_devices /dev/null" | debconf-communicate
echo "set grub-pc/install_devices_empty true" | debconf-communicate

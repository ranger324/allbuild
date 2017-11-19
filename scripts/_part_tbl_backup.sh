[ -z "$1" ] && DEV=/dev/sda
sfdisk -d $DEV > part.save 2>/dev/null

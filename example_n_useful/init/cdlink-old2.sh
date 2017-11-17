udevadm info --name=sr0 --query=property #| \
exit 0
while read ATTR; do
    case $ATTR in
	ID_CDROM=1)
	    ln -sf sr0 /dev/cdrom
	;;
	ID_CDROM_CD_RW=1)
	    ln -sf sr0 /dev/cdrw
	;;
	ID_CDROM_DVD=1)
	    ln -sf sr0 /dev/dvd
	;;
	ID_CDROM_DVD_RW=1)
	    ln -sf sr0 /dev/dvdrw
	;;
    esac
done

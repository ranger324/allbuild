##source firmware fsroot /media/root/43e2ba7d-0832-4e10-b3a5-3b7f218a0658
##copy destination /dest
##source list of kernel image's firmwares /lib/modules/4.20.15/firmware.for.builtins
cd /media/root/43e2ba7d-0832-4e10-b3a5-3b7f218a0658
while read firmware; do
    [ -e lib/firmware/"$firmware" ] && cp --parents lib/firmware/"$firmware" /dest
done < /lib/modules/4.20.15/firmware.for.builtins
##

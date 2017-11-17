echo -n > binfile.bin
od -v -A n -t x1 adb | \
while read A B C D E F G H I J K L M N O P; do
printf "\x${A}\x${B}\x${C}\x${D}\x${E}\x${F}\x${G}\x${H}\x${I}\x${J}\x${K}\x${L}\x${M}\x${N}\x${O}\x${P}" >> binfile.bin
done

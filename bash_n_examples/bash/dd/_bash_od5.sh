#IFS=$' '
echo -n > binfile.bin
hexdump -ve '1/1 "%.2x"' adb | \
while read -r -N 2 char; do
printf "\x${char}" >> binfile.bin
done

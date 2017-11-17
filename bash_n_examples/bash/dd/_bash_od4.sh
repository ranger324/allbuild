#IFS=$' '
echo -n > binfile.bin
od -v -An -t x1 adb | tr -d '\n' | \
while read -r -N 3 char; do
char=${char:1:2}
printf "\x${char}" >> binfile.bin
done

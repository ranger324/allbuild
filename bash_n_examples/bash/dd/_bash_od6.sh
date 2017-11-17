#IFS=$' '
echo -n > binfile.bin
hexdump -ve '1/1 "%.2x"' adb | xxd -r -p > binfile.bin

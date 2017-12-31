lsfirmware | grep "^MISSING " | \
while read A B FW; do
    echo "$FW"
done > fw.lst

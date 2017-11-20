#grep config symbols
find -name Kconfig | \
    xargs grep -i "^[[:space:]]*config[[:space:]]\|^[[:space:]]*menuconfig[[:space:]]" | cut -d : -f 2 | \
grep "MTK_\|_MTK\|MEDIATEK_\|_MEDIATEK\|MT65" | \
while read c config; do
    echo "CONFIG_$config=y" >> ../.config
done

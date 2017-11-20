
cp .config .config.new
CFG=.config.new

find drivers -type f -name Kconfig ! -path "drivers/parisc/*" -a ! -path "drivers/pci/*" -a ! -path "drivers/base/*" -a ! -path "drivers/bus/*" \
    -a ! -path "drivers/char/*" -a ! -path "drivers/clk/*" -a ! -path "drivers/tty/*" | \
    xargs -r grep -i "^[[:space:]]*config[[:space:]]\|^[[:space:]]*menuconfig[[:space:]]" | cut -d : -f 2 | \
while read c config; do
    sed -i "s%^CONFIG_$config=.*%# CONFIG_$config is not set%" $CFG
done

find net -name Kconfig | xargs -r grep -i "^[[:space:]]*config[[:space:]]\|^[[:space:]]*menuconfig[[:space:]]" | \
    cut -d : -f 2 | \
while read c config; do
    sed -i "s%^CONFIG_$config=.*%# CONFIG_$config is not set%" $CFG
done

find sound -name Kconfig | xargs -r grep -i "^[[:space:]]*config[[:space:]]\|^[[:space:]]*menuconfig[[:space:]]" | \
    cut -d : -f 2 | \
while read c config; do
    sed -i "s%^CONFIG_$config=.*%# CONFIG_$config is not set%" $CFG
done

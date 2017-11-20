echo "CONFIG_EXTRA_FIRMWARE=\"$((cd /lib/firmware; find intel-ucode -mindepth 1; find amd-ucode -mindepth 1 -name "*.bin" ) | LC_ALL=C sort | tr '\n' ' ' | sed 's% $%%')\""
echo "CONFIG_EXTRA_FIRMWARE_DIR=\"/lib/firmware\""

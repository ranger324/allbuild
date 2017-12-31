find package -type f -name "Config.in" | \
    xargs -r grep -h "config[[:space:]]\+BR2_PACKAGE_\|menuconfig[[:space:]]\+BR2_PACKAGE_" | \
    sed -e 's/menuconfig[[:space:]]\+//' -e 's/config[[:space:]]\+//' -e 's/.*/&=y/' > .config.set

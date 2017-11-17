start-stop-daemon -K -q -p /run/dhcpcd-wlan0.pid
start-stop-daemon -K -q -p /run/wpa_supplicant.pid
ip link set dev wlan0 down

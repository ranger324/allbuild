eval `udevadm info -q property /sys/class/net/wlan0 | grep "^ID_NET_NAME_PATH="`
#echo $ID_NET_NAME_PATH
ip link set wlan0 name $ID_NET_NAME_PATH

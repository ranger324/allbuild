[ -z "$1" ] && BR=2 || BR=$1
echo $BR > $(find /sys -name "brightness")

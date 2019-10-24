thermal=`ls /sys/class/hwmon/*/temp1_input 2> /dev/null | head -n 1`
if [ -e $thermal ]; then
    therm=$(cat $thermal)
    temp=$(echo "scale=1; $therm/1000" | bc)
fi
if [ -n "$temp" ]; then
    cpu="[${temp}°C]"
    echo "$cpu"
fi

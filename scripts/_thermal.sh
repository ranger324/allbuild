thermal="/sys/class/hwmon/hwmon0/temp1_input"
if [ -e $thermal ]; then
    therm=$(cat $thermal)
    temp=$(echo "scale=1; $therm/1000" | bc)
fi
if [ -n "$temp" ]; then
    cpu="[${temp}°C]"
fi
echo "$cpu"

#find /var/log -name "*.log" -size +100k -printf "%-20f%+10s\n"
find /var/log -name "*.log" -size +100k -printf "%s %f\n"

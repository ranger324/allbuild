#replace \040 " "
cat /proc/mounts | cut -d ' ' -f 2 | while read -r line; do MNTP=$(echo -ne "$line"); echo "*${MNTP}*"; done

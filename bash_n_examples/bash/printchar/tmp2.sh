
echo asdfas |wc -L
sp=kldajs
echo ${#sp}
echo ${sp::2}
echo $COLUMNS
i=1
#sp='/-\|'

sp=' ░▒▓██'
echo -n ' '
while true; do
sleep 0.2
#ASD="${sp:i++%${#sp}:1}"
#echo "${i}"
printf "\b${sp:i++%${#sp}:1}"
done

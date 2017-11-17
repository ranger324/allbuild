echo -ne "\033[2J" > $(cat /run/ttynum)
echo -ne "\033[0;0H" > $(cat /run/ttynum)

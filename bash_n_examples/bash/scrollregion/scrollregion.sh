#scrollregion
trap "echo -en '\033[h\033[r'" 0 1 2 5 15
LINES=`stty size | cut -d " " -f 1`
#LINES=`ttysize h`
#w width - stty size | cut -d " " -f 2
#h height - stty size | cut -d " " -f 1
row=$((LINES - 5))
echo -en "\033[6h\033[${row};${LINES}r\033[2J\033[${row};1H"
ls -lR /
echo -en "\033[h\033[r"

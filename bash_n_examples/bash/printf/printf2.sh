num=`stty size | cut -d ' ' -f 2`
char="█"
string="string"
lenstr="${#string}"
space=`expr \( $num - $lenstr \) / 2`
expr $space + $lenstr + $space
printnum=`expr $lenstr + $space`
line="$(printf "%${num}c" " ")"
line="${line// /${char}}"
echo -n "${line}"
printf "%-${num}s" "$string"
echo -n "${line}"
printf "%${printnum}s\n" "$string"
echo -n "${line}"
printf "%${num}s" "$string"
echo -n "${line}"

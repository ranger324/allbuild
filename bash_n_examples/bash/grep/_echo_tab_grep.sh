A=$'\t'; echo "*$A*"; echo "$A" | grep -qP "[\t]" && echo ok
A="\\"; echo "*$A*"; echo "$A" | grep -qP "[\t]" && echo ok
A="\\"; echo "*$A*"; echo "$A" | grep -q "[\t]" && echo ok

T=$'\t'
T=$'\x09'
shopt -s extglob; A=`echo -ne "a a s d  a  dbs a  a \t s a  ca a a  "`; B="${A//[	]/ }"; C="${B//+([ ])/ }"; D=${C//[^ ]/}; echo ${#D}
#shopt -s extglob; A="a a s d  a  d\nbs a  a \t s a  \nca a a  \n"; echo -ne "${A//+([[:space:]])/ }"
#shopt -s extglob; A="a a s d  a  d\nbs a  a \t s a  \nca a a  \n"; echo -ne "${A//+([	])/ }"

shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; B="${A//+([	])/ }"
shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; echo "${B//+([ ])/ }"
shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; echo "${A//$'\x09'/ }"
shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; echo "${A//$T/ }"



shopt -s extglob; A=`echo -ne " w a a s d  a  dbs a  a \t s a  ca a a  "`; B="${A//[	]/ }"; C="${B//+([ ])/ }"; D=${C//[^ ]/}; echo ${#D}

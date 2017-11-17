#prefix suffix modify

echovars0()
{
    local str=
    for i in `seq 1 3`; do
	str="$str $i"
    done
    str="${str:1}"
    echo "$str"
}

echovars1()
{
    local str=@
    for i in `seq 1 3`; do
	str="$str$i@"
    done
    echo "$str"
}

echovars()
{
    local str
    for i in `seq 1 3`; do
	[ -z "$str" ] && str="$i" || str="$str $i"
    done
    echo "$str"
}
#echovars0
#echovars1
#echovars
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

n_rvar=${#D}
rvar=var
set -f

echovars()
{
    local str
    for ((i=1; i<=n_rvar; i++)); do
	[[ -z "$str" ]] && str="$rvar$i" || str="$str $rvar$i"
    done
    echo "$str"
}

echo asdasd | while read a; do
echo $a
done
echovars
#IFS=' ' read arg1 arg2 arg3 <<< 'val1|val2|val3'
IFS=' ' read -r `echovars` <<< "$C"
echo $var1
for ((i=1; i<=n_rvar; i++)); do
#    TMPVAR="var$i"
#    eval TMPVAR2='$'$TMPVAR
#    eval var$i=2
#    TMPVAR2=`eval 'echo $'$TMPVAR`
#    eval echo '$'var$i a
#    echo -n "var$i#"
    eval tmpvar='$'$rvar$i
    ##
    ##
    echo "*$tmpvar*"
done

shopt -s lastpipe
#read -r asd
echo asd asd | read -r asd
echo $asd

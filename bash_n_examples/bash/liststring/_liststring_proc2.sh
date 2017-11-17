#prefix suffix modify

echovars0()
{
    local str=
#    for ((i=1; i<=n_rvar; i++)); do
    for i in `seq 1 3`; do
	str="$str $i"
    done
    str="${str:1}"
    echo "$str"
}

echovars1()
{
    local str=@
#    for ((i=1; i<=n_rvar; i++)); do
    for i in `seq 1 3`; do
	str="$str$i@"
    done
    echo "$str"
}

echovars()
{
    local str
#    for ((i=1; i<=n_rvar; i++)); do
    for i in `seq 1 3`; do
	[ -z "$str" ] && str="$i" || str="$str $i"
    done
    echo "$str"
}
#echovars0
#echovars1
#echovars
T=$'\x09'
shopt -s extglob; A=`echo -ne "a a s d  a  dbs a  a \t s a  ca a a  "`; B="${A//[	]/ }"; C="${B//+([ ])/ }"; D=${C//[^ ]/}; echo ${#D}
#shopt -s extglob; A="a a s d  a  d\nbs a  a \t s a  \nca a a  \n"; echo -ne "${A//+([[:space:]])/ }"
#shopt -s extglob; A="a a s d  a  d\nbs a  a \t s a  \nca a a  \n"; echo -ne "${A//+([	])/ }"

shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; B="${A//+([	])/ }"
shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; echo "${B//+([ ])/ }"
shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; echo "${A//$'\x09'/ }"
shopt -s extglob; A=`echo -ne "a a s d  a  d\nbs a  a \t s a  \nca a a  \n"`; echo "${A//$T/ }"



shopt -s extglob; A=`echo -ne " w a a s d  a  dbs a  a \t s a  ca a a  q"`; B="${A//[	]/ }"; C="${B//+([ ])/ }"; D=${C//[^ ]/}; echo ${#D}
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
VVARS=`echovars`

#IFS=' ' read arg1 arg2 arg3 <<< 'val1|val2|val3'
IFS=' ' read -r $VVARS <<< "$C"
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


#
echo asd asd | while read a; do
echo $a
done

#last pipe no subprocess
shopt -s lastpipe
echo asd asd | read -r asd
echo $asd
##error wo linefeed->echo -n "$C" | IFS=' ' read -r `echovars`
echo "$C" | IFS=' ' read -r $VVARS
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


#IFS=$' ' echo "$C" | while read -r str; do echo $str; done
#OIFS=$IFS
#IFS=$' '
#echo "$C" | while read -r str; do echo "$str"; done
#IFS=$OIFS
#delimiter - field separator
fsep=' '
echo "*$C*"
#OIFS=$IFS
#IFS=$' '

C=${C#$fsep}
[ "${C:${#C}-1:1}" != "$fsep" ] && C="$C$fsep"
echo "*$C*"
echo "$C" | while read -r -d "$fsep" str; do echo "$str"; done
#IFS=$OIFS


asd()
{
A=("a" "b" "c")
echo ${!A[@]}
echo "##"
for i in ${!A[@]}; do
    echo "${A[i]}"
done
echo "##"
unset A[1]

for i in ${!A[@]}; do
    echo "${A[i]}"
done

echo ${!A[@]}
echo "##"
echo "${!A[@]}" | tr ' ' '\0' | xargs -r -0 -i sh -c "echo {}"
echo "##2xargs"
echo -n "${!A[@]}" | tr ' ' '\0' | xargs -r -0 -i sh -c "echo {}"
echo "##"
echo "${!A[@]} " | while read -d ' ' num; do echo $num; done
echo "##"
echo -n "${!A[@]} " | while read -d ' ' num; do echo $num; done
}

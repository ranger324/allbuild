#echo v1 v2 v3

#A="v1 v2 v3"
#cat /etc/profile | \
#while read -r $A; do
#echo $v1
##case var in
##"")
##;;
#done
#eval read -r readvar1
#eval read -r readvar1 readvar2
#eval read -r readvar1 readvar2 readvar3


#set +f
#eval echo "/???/*"
#for i in /???/*; do ...
#ls /???/*
##set -f
n_rvar=3
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

VARS=`echovars`
#A="v1 v2 v3"
cat /etc/profile | \
while read -r $VARS; do

#echo $var1
for ((i=1; i<=n_rvar; i++)); do
#    TMPVAR="var$i"
#    eval TMPVAR2='$'$TMPVAR
#    eval var$i=2
#    TMPVAR2=`eval 'echo $'$TMPVAR`
#    eval echo '$'var$i a
#    echo -n "var$i#"
    eval tmpvar='$'$rvar$i
    ##
    [[ -z "$tmpvar" ]] && break
    ##
    if [[ "$i" = 1 ]]; then
        echo -n "*$tmpvar*"
    else
	echo -n " *$tmpvar*"
    fi
done
echo

#case var in
#"")
#;;
done


#VAR2.6.34.9-lt -> VAR2_6_34_9_lt
#ASD=1
#eval ASD$ASD=2
#TMPVAR="ASD$ASD"
#eval 'echo $'$TMPVAR


[ -z "$1" ] && echo "Add params" && exit 1
#set -f
#set noglob
#shopt -s nullglob
#shopt -u direxpand
#shopt -u globstar
params_def="$@"
OIFS=$IFS
IFS=$'\n'
params_linefeed="$*"
IFS=$OIFS

#for i in $params_def; do
#echo "#$i#"
#done

#for i in $params_linefeed; do
#echo "#$i#"
#done

#echo "$params_def" | \
#while read i; do
#echo "#$i#"
#done

#######################
# eg.: bash put args into array
while test $# -gt 0; do
    echo "#$1#"
    shift
done

#######################
xyz_func()
{
while test $# -gt 0; do
    echo "#$1#"
    shift
done
}
set -f
#params without '"'
xyz_func $params_def
set +f


#######################
### while loop - variable doesn't get out
A=
echo "$params_linefeed" | \
while read i; do
    A=1
    echo "#$i#"
done
echo $A

#######################
### bash while loop - with simple command ##bash
#A=
#while read i; do
#    A=1
#    echo "#$i#"
#done < <(echo "$params_linefeed")
#echo $A

#######################
A=
set -f
for i in $params_def; do
    echo "#$i#"
done

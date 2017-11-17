#IFS=$'\x1F'
#delim=$'\x1F'

IFS=$'#'
delim=$'#'
declare -a A

##init array
#A=(${delim}aas\ daf${delim}sfasfa\ asda${delim}adwdw${delim}qqaas\ dafqq)
A=(${delim}"aas daf"${delim}"sfasfa asda"${delim}"adwdw"${delim}"qqaas dafqq")
A[${#A[*]}]=${delim}
##

[[ "${A[*]}" =~ "${delim}qqaas dafqq${delim}" ]] && echo match a

###
EL_NUM=$((${#A[*]} - 2))
i=1
while (($i <= $EL_NUM)); do
echo "$i#${A[$i]}"
let i++
done
###

[[ "${A[*]}" =~ ${delim}aa[s\ ]{2}daf${delim} ]] && echo match a
[[ "${A[*]}" =~ "${delim}aas daf${delim}" ]] && echo match a
[[ "${A[*]}" =~ "${delim}qqaas dafqq${delim}" ]] && echo match a

###
WR_NUM=$((${#A[*]} - 1))
A[$WR_NUM]="d f g"
A[$WR_NUM+1]=${delim}
###

###
EL_NUM=$((${#A[*]} - 2))
i=1
while (($i <= $EL_NUM)); do
echo "$i#${A[$i]}"
let i++
done
###

[[ "${A[*]}" =~ "${delim}d f g${delim}" ]] && echo match a

#IFS=$'\x1F'
#delim=$'\x1F'

IFS=$'#'
delim=$'#'

declare -a A
###
A[0]=${delim}
###
A[1]="aas daf"
A[2]="sfasfa asda"
A[3]="adwdw"
A[4]="qqaas dafqq"
A[5]=${delim}

[[ "${A[*]}" =~ ${delim}aa[s\ ]{2}daf${delim} ]] && echo match 0
[[ "${A[*]}" =~ "${delim}aas daf${delim}" ]] && echo match a
[[ "${A[*]}" =~ "${delim}sfasfa asda${delim}" ]] && echo match b
[[ "${A[*]}" =~ "${delim}adwdw${delim}" ]] && echo match c
[[ "${A[*]}" =~ "${delim}qqaas dafqq${delim}" ]] && echo match d

A[5]="ww a"
A[6]=${delim}

[[ "${A[*]}" =~ "${delim}ww a${delim}" ]] && echo match e

###
EL_NUM=$((${#A[*]} - 2))
i=1
while (($i <= $EL_NUM)); do
echo "$i#${A[$i]}"
let i++
done
###

###
WR_NUM=$((${#A[*]} - 1))
A[$WR_NUM]="d f g"
A[$WR_NUM+1]="ww a"
A[$WR_NUM+2]="fasf"
A[$WR_NUM+3]="re"
A[$WR_NUM+4]="qw"
A[$WR_NUM+5]=${delim}
###

[[ "${A[*]}" =~ "${delim}re${delim}" ]] && echo match f
[[ "${A[*]}" =~ "${delim}qw${delim}" ]] && echo match g

###
EL_NUM=$((${#A[*]} - 2))
i=1
while (($i <= $EL_NUM)); do
echo "$i#${A[$i]}"
let i++
done
###

WR_NUM=$((${#A[*]} - 1))
echo "wr_num: $WR_NUM"

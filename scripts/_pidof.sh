[ -z "$1" ] && exit 1
process="$1"
pid=`ps ax | awk -v var="$process" '{if (match($5, ".*/" var "$") || $5 == var) print $1}'`
#pid=`ps ax | awk -v pat="$process" 'BEGIN {var1=".*/" pat "$"}; {if ($5 ~ var1 || $5 == pat) result=$1}; END {print result}'`
echo $pid

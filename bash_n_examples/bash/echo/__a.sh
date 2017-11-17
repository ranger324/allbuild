echo "will run" sh _get_group_def6.sh \"*\" "|" less

#sh _get_group_def6.sh "*" | less
a='sh _get_group_def6.sh "*" | less'
A="echo $a"
B=$(echo "$A" | sed -e 's%"%\\"%g' -e 's/|/"|"/g')
echo "$B" > __b.sh
sh __b.sh

echo "<-" sh _get_group_def6.sh \"*\" "|" less

proc()
{
while read var; do
echo "$var"
echo $var
done < /dev/stdin
}
#set -f
if [ -p /dev/stdin ]; then
proc
fi
echo "*$var*"

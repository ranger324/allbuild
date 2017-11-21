ls_tmp()
{
#packages wanted with deps + local if exists
echo -e "b 1.0.2g 4\nagsfd 1.0.2g 1\nhgsaf 1.0.2g 2\ndgrggw 1.0.2g 0\nhgsaf 1.0.2g 1\nb 1.0.2g 3\nagsfd 1.0.2g 0\nhgsaf 1.0.2e 1"| sort -V -r -k 2,3| \
while read name ver rev; do
    if ! echo "$processed" | grep -q "^$name$"; then
	echo "$name $ver $rev"
	[ -z "$processed" ] && processed="$name" || processed=`echo -ne "$processed\n$name"`
    fi
done
}
ls_tmp | \
while read tmp; do
    echo "$tmp"
done

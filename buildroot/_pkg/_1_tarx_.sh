mkdir -p /dest2
for i in /dest/*.tar.gz; do
echo $i
tar xzf $i -C /dest2 --wildcards "var/lib/instpkg/*"
done

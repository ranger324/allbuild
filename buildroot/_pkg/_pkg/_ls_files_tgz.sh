cd /dest
rm -f *.files
for i in *.tar.gz; do echo $i; tar tzf $i > $i.files; done

cd /dest
grep -v "/$" *.files > /_aa
cut -d : -f 2- /_aa | sort | tee /_bb | sort -u > /_cc
comm -23 /_bb /_cc | sort -u | \
while read file; do
    grep ".*:$file$" /_aa
done
##grep -f

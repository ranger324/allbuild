#diff --new-line-format="+%L" --old-line-format="-%L" --unchanged-line-format="&%L" .rem_cache.tmp1.sort3 .rem_cache.tmp1.sort5
#diff -a --suppress-common-lines .rem_cache.tmp1.sort3 .rem_cache.tmp1.sort5
##-i ignore case
##-a text files
grep -vxf .rem_cache.tmp1.sort3 .rem_cache.tmp1.sort5
##-x whole line match ^..$
#comm works only with "sort" not "sort -V" or other
##comm -23 --nocheck-order /tmp/file1 /tmp/file3

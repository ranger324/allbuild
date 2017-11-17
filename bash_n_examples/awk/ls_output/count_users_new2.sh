#!/bin/sh

find . -type f -print0 | xargs -r -0 ls -isl | \
awk -f count.awk | \
sort +0nr -2 +2d | \
(echo "size count user group"; cat -) | \
tr ' ' '\t'



#find . -type f -print | xargs ls -isl | \
#awk -f count.awk | \
# numeric sort - biggest numbers first
# sort fields 0 and 1 first (sort starts with 0)
# followed by dictionary sort on fields 2 + 3
#sort +0nr -2 +2d | \
# add header
#(echo "size count user group"; cat -) | \
# convert space to tab - makes it nice output
# the second set of quotes contains a single tab character
#tr ' ' '\t'
# done - I hope you like it

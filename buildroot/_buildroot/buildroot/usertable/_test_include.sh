#! /bin/sh

touch tmpinclude.sh
source tmpinclude.sh > /dev/null 2>&1
#not reached?
ret=$?
rm -f tmpinclude.sh
exit $ret

LINUX_INCL=/usr/include
LINUX_VERSION_CODE=`cat $LINUX_INCL/linux/version.h | sed -n 's/.\+LINUX_VERSION_CODE \([[:digit:]]\+\)$/\1/p'`
VSTR=`echo $LINUX_VERSION_CODE | perl -e '$version=<STDIN>; chomp($version); printf("%d.%d.%d\n", ($version >> 16) & 0xFF, ($version >> 8) & 0xFF, $version & 0xFF);'`
echo "$VSTR"

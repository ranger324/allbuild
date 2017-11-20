LINUX_INCL=/usr/include
LINUX_VERSION_CODE=`cat $LINUX_INCL/linux/version.h | sed -n 's/.\+LINUX_VERSION_CODE \([[:digit:]]\+\)$/\1/p'`
A=$(( $LINUX_VERSION_CODE >> 16 ))
B=$(( $LINUX_VERSION_CODE >> 8 ))
C=$(( $LINUX_VERSION_CODE & 0xff ))
D=$(( $A & 0xff ))
E=$(( $B & 0xff ))
echo "$D.$E.$C"

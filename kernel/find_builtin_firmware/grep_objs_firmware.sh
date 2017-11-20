#add gpu include
#(copy to kernel dir)

#KERNEL=/root/linux-4.11
KERNEL=$(cd $(dirname "$0") && pwd -P)

ARCH=x86

export MPATH=$PWD
find -type f -name "built-in.o" | sed 's%/built-in\.o%%' | \
while read line; do
    cd "$line"
    find -maxdepth 1 -name "*.o" -printf "%f\n" | grep -v "/built-in.o$" | \
    while read obj; do
	if grep -q "MODULE_FIRMWARE" `echo "$obj" | sed 's/\.o$/\.c/'` 2> /dev/null; then
	    echo -n "$line/"
	    echo "$obj" | sed 's/\.o$/\.c/'
	fi
    done
    cd $MPATH
done | \
while read line; do
    if MODDEF=$(grep "MODULE_FIRMWARE([^\"]" $line); then
	echo "$MODDEF" | sed -e 's/.*(//' -e 's/);$//' | sed "s%.*%$line &%"
    else
	grep "MODULE_FIRMWARE(\"" "$line"
    fi
done | \
while read file define; do
case $file in
MODULE*)
    echo $file | sed -e 's/MODULE_FIRMWARE(//' -e 's/);$//'
;;
*)
(gcc -dM -E $file \
	-I$KERNEL/include \
	-I$KERNEL/arch/$ARCH/include/uapi \
	-I$KERNEL/arch/$ARCH/include/generated/uapi \
	-I$KERNEL/include/uapi \
	-I$KERNEL/include/generated/uapi \
	-include $KERNEL/include/linux/kconfig.h \
	-I$KERNEL/arch/$ARCH/include \
	-I$KERNEL/arch/$ARCH/include/generated/uapi \
	-I$KERNEL/arch/$ARCH/include/generated \
	-I$KERNEL/include \
	-I$KERNEL/include/drm | grep $define) 2> /dev/null | cut -d " " -f 3
;;
esac
done

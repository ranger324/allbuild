#! /bin/bash

#replace searched symbols

CFG=.config
[ "$1" = "-c" ] && cp .config .config.new && CFG=.config.new

#search Kconfig.debug entries
echo "Search and replace Kconfig.debug..."
find -name "Kconfig.debug" | xargs grep "^[[:space:]]*config[[:space:]]\|^[[:space:]]*menuconfig[[:space:]]" | \
    cut -d : -f 2 | \
while read c config; do
    sed -i "s%^CONFIG_$config=.*%# CONFIG_$config is not set%" $CFG
done

#turn off CONFIG_.*_DEBUG CONFIG_DEBUG_.* CONFIG_.*_DEBUG_ENABLE
echo "Replace CONFIG_._DEBUG CONFIG_DEBUG_. CONFIG_._DEBUG_ENABLE ..."
sed -i "s%^\(CONFIG_.*_DEBUG\)=[ym]%# \1 is not set%" $CFG
sed -i "s%^\(CONFIG_DEBUG_.*\)=[ym]%# \1 is not set%" $CFG
sed -i "s%^\(CONFIG_.*_DEBUG_ENABLE\)=y%# \1 is not set%" $CFG
sed -i "s%^\(CONFIG_DEBUG_.*\)=[0-9]\+%# \1 is not set%" $CFG

#turn off list
TURNOFF=" \
CONFIG_COMPILE_TEST \
CONFIG_SYSFS_DEPRECATED \
CONFIG_DEBUG_INFO \
CONFIG_ENABLE_WARN_DEPRECATED \
CONFIG_DEBUG_DRIVER \
CONFIG_DEBUG_DEVRES \
CONFIG_DEBUG_TEST_DRIVER_REMOVE \
CONFIG_DRM_DEBUG_MM_SELFTEST \
CONFIG_TEST_ASYNC_DRIVER_PROBE \
CONFIG_DEBUG_HOTPLUG_CPU0 \
CONFIG_CMLINE_BOOL \
CONFIG_CMLINE_OVERRIDE \
CONFIG_COMPAT_BRK \
CONFIG_KPROBES \
CONFIG_COMPAT_VDSO \
CONFIG_CFG80211_DEVELOPER_WARNINGS \
CONFIG_LEGACY_PTYS \
CONFIG_NTFS_RW \
CONFIG_MTD_TESTS \
CONFIG_OCFS2_DEBUG_FS \
CONFIG_OCFS2_DEBUG_MASKLOG \
CONFIG_NL80211_TESTMODE \
CONFIG_DMA_FENCE_TRACE \
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING \
CONFIG_DM_DEBUG_BLOCK_STACK_TRACING \
CONFIG_USB_OTG_BLACKLIST_HUB \
CONFIG_LOGO \
CONFIG_NET_PKTGEN \
CONFIG_BRCM_TRACING \
CONFIG_BTRFS_FS_RUN_SANITY_TESTS \
CONFIG_BTRFS_FS_CHECK_INTEGRITY \
CONFIG_CDROM_PKTCDVD_WCACHE \
CONFIG_THERMAL_EMULATION \
CONFIG_RTC_DS1685_PROC_REGS \
CONFIG_RTC_DS1685_SYSFS_REGS \
"

echo "Replace turn-off list..."
for i in $TURNOFF; do
    sed -i "s%^$i=.*%# $i is not set%" $CFG
done

#turn on list - set to (y)
TURNON=" \
CONFIG_BINFMT_SCRIPT \
"

echo "Replace turn-on list..."
for i in $TURNON; do
    sed -i -e "s%^$i=[^y]\+%$i=y%" -e "s%^# $i is not set%$i=y%" $CFG
done

#CONFIG_NR_CPUS=64

grep_key_conf_elements()
{
##find -name "Kconfig" | xargs grep -n -B 1 "tristate[[:space:]]\+['\"].*(EXPERIMENTAL).*['\"]\|bool[[:space:]]\+['\"].*(EXPERIMENTAL).*['\"]\|int[[:space:]]\+['\"].*(EXPERIMENTAL).*['\"]"
##find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*development.*['\"]\|bool[[:space:]]\+['\"].*development.*['\"]\|int[[:space:]]\+['\"].*development.*['\"]"
TMPVAR=`find -name "Kconfig" | xargs grep -n -B 1 "tristate[[:space:]]\+['\"].*(DANGEROUS).*['\"]\|bool[[:space:]]\+['\"].*(DANGEROUS).*['\"]\|int[[:space:]]\+['\"].*(DANGEROUS).*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
TMPVAR=`find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*experimental.*['\"]\|bool[[:space:]]\+['\"].*experimental.*['\"]\|int[[:space:]]\+['\"].*experimental.*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
TMPVAR=`find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*obsolete.*['\"]\|bool[[:space:]]\+['\"].*obsolete.*['\"]\|int[[:space:]]\+['\"].*obsolete.*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
TMPVAR=`find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*deprecated.*['\"]\|bool[[:space:]]\+['\"].*deprecated.*['\"]\|int[[:space:]]\+['\"].*deprecated.*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
TMPVAR=`find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*debug.*['\"]\|bool[[:space:]]\+['\"].*debug.*['\"]\|int[[:space:]]\+['\"].*debug.*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
TMPVAR=`find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*(DEVELOPMENT).*['\"]\|bool[[:space:]]\+['\"].*(DEVELOPMENT).*['\"]\|int[[:space:]]\+['\"].*(DEVELOPMENT).*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
TMPVAR=`find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*for testing.*['\"]\|bool[[:space:]]\+['\"].*for testing.*['\"]\|int[[:space:]]\+['\"].*for testing.*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
TMPVAR=`find -name "Kconfig" | xargs grep -i -n -B 1 "tristate[[:space:]]\+['\"].*(unsafe).*['\"]\|bool[[:space:]]\+['\"].*(unsafe).*['\"]\|int[[:space:]]\+['\"].*(unsafe).*['\"]"`
[ ! -z "$TMPVAR" ] && echo -ne "$TMPVAR\n--\n"
}

rework_key_conf_elements()
{
local NUM=0
local line line1 line2
grep_key_conf_elements | \
while read line; do
case "$line" in
    --)
	NUM=0
	if echo "$line1" | grep -qv "/Kconfig-[0-9]*-config\|/Kconfig-[0-9]*-menuconfig"; then
	    F_NUM=2
	    while line11=`head -n $N_LINE $F_LINE | tail -n $F_NUM | head -n 1 | grep -v "^[[:space:]]*config[[:space:]]\+\|^[[:space:]]*menuconfig[[:space:]]\+"`; do
		F_NUM=$(expr $F_NUM + 1)
	    done
	    sed -n "$(expr $N_LINE - $F_NUM + 1)p" $F_LINE 1>&2
	else
	    sed -n "$(expr $N_LINE - 1)p" $F_LINE 1>&2
	fi
    ;;
    *)
	NUM=$(expr $NUM + 1)
	if [ "$NUM" = 1 ]; then
	    line1="$line"
	fi
	if [ "$NUM" = 2 ]; then
	    line2="$line"
	    N_LINE=$(echo "$line2"| cut -d : -f 2)
	    F_LINE=$(echo "$line2"| cut -d : -f 1)
	    echo $line2
	fi
    ;;
esac
done
}

echo "Grepping info section..."
(rework_key_conf_elements > /dev/null) 2>&1 | \
while read c config; do
#    echo $config
    sed -i "s%^CONFIG_$config=.*%# CONFIG_$config is not set%" $CFG
done

#! /bin/bash
#simplified dependency grep
#needs review
#gives some automation
#- no "default y" lines
#"^[[:space:]]\+bool\|^[[:space:]]\+tristate\|^[[:space:]]\+depends[[:space:]]\+on\|^[[:space:]]\+select\|^[[:space:]]\+---help---\|^[[:space:]]\+help\|^[[:space:]]\+default\|^[[:space:]]\+int"

CFG=.config
[ "$1" = "-c" ] && cp .config .config.new && CFG=.config.new

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

echo -n > /tmp/file
#echo "Grepping info section..."
(rework_key_conf_elements > /dev/null) 2>&1 | \
while read c config; do
#    echo "$config"
    echo "$config" | tee -a /tmp/file
done

cat /tmp/file | \
while read config; do
    echo "$config"
    find -type f -name "Kconfig" | xargs -r grep -n "[[:space:]]\+[!(]*$config[=)]*[[:space:]]\+\|[[:space:]]\+[!(]*$config[=)]*$"
done | \
grep -v "^\./.*/Kconfig:[0-9]\+:config[[:space:]]\+\|\./.*/Kconfig:[0-9]\+:menuconfig[[:space:]]\+" | \
while read line; do
case "$line" in
./*)
    echo "$CFG_VAR $line"
;;
*)
    CFG_VAR="$line"
;;
esac
done | \
while read line; do
    CFG_VAR=$(echo "$line" | cut -d ' ' -f 1)
    TMPVAR=$(echo "$line" | cut -d ' ' -f 2)
    FILE=$(echo "$TMPVAR" | cut -d ':' -f 1)
    NUM=$(echo "$TMPVAR" | cut -d ':' -f 2)

    LINE=`sed -n "${NUM}p" "$FILE"`
    LINE=`echo "$LINE" | sed -e 's/(/ /g' -e 's/)/ /g' -e 's/!/ /g' -e 's/=/ /'`
    ! echo "$LINE" | grep -q "[[:space:]]\+$CFG_VAR[[:space:]]\+\|[[:space:]]\+$CFG_VAR$" && continue

    if sed -n "${NUM}p" "$FILE" | grep -q "^[[:space:]]\+depends[[:space:]]\+on\|^[[:space:]]\+select[[:space:]]\+"; then
	if [ "$NUM" -gt 1 ]; then
	    ANUM=$(expr $NUM - 1)
	    while sed -n "${ANUM}p" "$FILE" | grep -qv "^config[[:space:]]\+\|^menuconfig[[:space:]]\+"; do
		[ "$ANUM" -eq 1 ] && break
		ANUM=$(expr $ANUM - 1)
	    done
	    LINE=$(sed -n "${ANUM}p" "$FILE")
	    echo "$CFG_VAR $LINE"
	    echo "$LINE" | sed -e 's/^config[[:space:]]\+//' -e 's/^menuconfig[[:space:]]\+//' >> /tmp/file
	fi
    else
	if [ "$NUM" -gt 1 ]; then
	    ANUM=$(expr $NUM - 1)
	    while sed -n "${ANUM}p" "$FILE" | grep -q '\\$'; do
		[ "$ANUM" -eq 1 ] && break
		ANUM=$(expr $ANUM - 1)
	    done
	    if sed -n "${ANUM}p" "$FILE" | grep -q "^[[:space:]]\+depends[[:space:]]\+on\|^[[:space:]]\+select[[:space:]]\+"; then
		if [ "$ANUM" -gt 1 ]; then
		    ANUM=$(expr $ANUM - 1)
		    while sed -n "${ANUM}p" "$FILE" | grep -qv "^config[[:space:]]\+\|^menuconfig[[:space:]]\+"; do
			[ "$ANUM" -eq 1 ] && break
			ANUM=$(expr $ANUM - 1)
		    done
		    LINE=$(sed -n "${ANUM}p" "$FILE")
		    echo "$CFG_VAR $LINE"
		    echo "$LINE" | sed -e 's/^config[[:space:]]\+//' -e 's/^menuconfig[[:space:]]\+//' >> /tmp/file
		fi
	    fi
	fi
    fi
done
sort -u /tmp/file > /tmp/file.tmp
mv /tmp/file.tmp /tmp/file
cat /tmp/file | \
while read config; do
    sed -i "s%^CONFIG_${config}=.*%# CONFIG_${config} is not set%" $CFG
done

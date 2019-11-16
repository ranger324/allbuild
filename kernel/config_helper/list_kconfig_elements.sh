#kernel configuration may take a lot of time
#by searching "descriptions" it may take less
#ugly words
#(firmware; free firmware; software; hardware)

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
	    while head -n $N_LINE $F_LINE | tail -n $F_NUM | head -n 1 | grep -qv "^[[:space:]]*config[[:space:]]\+\|^[[:space:]]*menuconfig[[:space:]]\+"; do
		F_NUM=$(expr $F_NUM + 1)
	    done
	    numtmp=$(expr $N_LINE - $F_NUM + 1)
	    echo "$F_LINE:${numtmp}"
	    #sed -n "$(expr $N_LINE - $F_NUM + 1)p" $F_LINE 1>&2
	else
	    numtmp=$(expr $N_LINE - 1)
	    echo "$F_LINE:${numtmp}"
	    #sed -n "$(expr $N_LINE - 1)p" $F_LINE 1>&2
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
	    #echo "$line2"
	fi
    ;;
esac
done
}

rework_key_conf_elements | \
while read line; do
    FILE=`echo "$line" | cut -d : -f 1`
    NUM=`echo "$line" | cut -d : -f 2`
    sh /bin/_find_file_section.sh -s -z -n -1 -2 "$FILE" "$NUM" "^comment\|^if\|^config\|^endif\|^choice\|^endchoice\|^endmenu\|^menuconfig\|^source\|^#"
done

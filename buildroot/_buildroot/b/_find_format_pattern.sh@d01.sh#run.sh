
#contpatt="[\]$"
contpatt="[\]$"
#patt1="err"
#patt2="asd"
patt1="err"
patt2="asd"
patt3="use"
nopatt="fgh"
#patt1="\$(STAGING_DIR)"
#patt2="\$(TARGET_DIR)"
sect_start="$patt1\|$patt2"
sect_stop="$patt1\|$patt2"


find -mindepth 2 -type f -name "*.mk" | \
while read file; do
    dash _find_file_section.sh -c -n -e -x "$file" "^define" "^endef"
#done | dash _find_format_pattern.sh@d0.sh -x "echo" "sed"


done | dash _find_format_pattern.sh@d01.sh -c -I -P '\$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P '[\]$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P '[\\]$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P -- '[\\]$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P -- "[\]$" "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -P -I -- '[\\]$' "err" "$patt3"
#done | dash _find_format_pattern.sh@d01.sh -c "[\]$" "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P -- "[\\]$" "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -- "[\]$" "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P '\$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P '[\]$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P '[\\]$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P -- '[\\]$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -I -P -- "[\]$" "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -P -I -- '[\\]$' "err" "$patt3"
#done | dash _find_format_pattern.sh@d01.sh -c "[\]$" "b" "c"


#done | dash _find_format_pattern.sh@d01.sh -c -I -P -- '[\\]$' "b" "c"
#done | dash _find_format_pattern.sh@d01.sh -c -- "[\]$" "b" "c"

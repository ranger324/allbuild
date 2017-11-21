sh _find_descriptions_4.sh | \
while read line; do
FILE=`echo "$line" | cut -d : -f 1`
NUM=`echo "$line" | cut -d : -f 2`
sh _find_file_section.sh -s -z -n -1 $FILE $NUM "^comment\|^if\|^config\|^endif\|^endchoice\|^endmenu\|^#"
done

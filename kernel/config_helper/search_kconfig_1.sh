#list config symbol parts of "Kconfig"s
find -type f -name "Kconfig" | \
while read file; do
    sh _find_file_section.sh -z -n -1 -2 "$file" "^config\|^menuconfig" "^comment\|^if\|^config\|^endif\|^choice\|^endchoice\|^endmenu\|^menuconfig\|^source\|^#"
done

#grep_key_conf_elements

#comment
#if
#config
#endif
#endchoice
#choice
#endmenu
#menuconfig
#source
##

#list config symbol parts of "Kconfig"s
#check "help" key word
find -type f -name "Kconfig" | \
while read file; do
    sh /bin/_find_file_section.sh -o -u -z -n -1 -2 "^[[:space:]]\+help$\|^[[:space:]]\+---help---$" "$file" "^config\|^menuconfig" "^comment\|^if\|^config\|^endif\|^choice\|^endchoice\|^endmenu\|^menuconfig\|^source\|^#"
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

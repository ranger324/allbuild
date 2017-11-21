for i in */Config.in; do
    sh _find_file_section.sh -1 -z -n "$i" '^[[:space:]]\+bool[[:space:]]\+"' "^comment\|^if\|^config\|^endif\|^endchoice\|^endmenu\|^#"
done

for i in *; do REV=$(echo $i | sed -n "s%\(.*\)-\([0-9]\+\)$%\2%p"); mkdir "$(echo $i | sed "s%-[0-9]\+$%%")-$(expr $REV - 1)"; done

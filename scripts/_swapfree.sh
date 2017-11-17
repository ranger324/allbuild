LC_ALL=C free | grep "^Swap:" | tr -d : | sed 's/[[:space:]]\+/ /g' | cut -d ' ' -f 2

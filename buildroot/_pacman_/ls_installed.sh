LC_ALL=C pacman -Sl | grep "\[installed.*\]$" | cut -d ' ' -f 2

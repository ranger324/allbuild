#read file sections - key word to key word
wget -q http://distrowatch.com/index.php -O dwatch.php
sh _find_file_section.sh dwatch.php "&nbsp;Latest Packages" "</table>" | \
    grep -o "&bull; <a href=.*>" | sed -e 's%&bull; <a href=%%' -e 's%>.*%%'

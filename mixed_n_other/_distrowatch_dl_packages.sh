#read file sections - key word to key word
wget -q http://distrowatch.com/packages.php -O dwatch_packages.php
sh _find_file_section.sh dwatch_packages.php "<table class=\"Auto\">  <tr>    <th class=\"TablesInvert\">Package</th>" "</table>" | \
    grep -o "<td><a href=.*>" | sed -e 's%<td><a href=%%' -e 's%>.*%%'

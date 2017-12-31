find -type f -a \( ! -perm 755 -a ! -perm 644 \) | while read line; do stat -c "%u %g %a %n" $line ; done

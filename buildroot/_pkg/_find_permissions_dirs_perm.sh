find -type d -a ! -perm 755 | while read line; do stat -c "%u %g %a %n" $line ; done

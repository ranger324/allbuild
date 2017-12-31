find -type f -a \( ! -group root -o ! -user root \) | while read line; do stat -c "%u %g %a %n" $line ; done

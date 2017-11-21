find -type l -name "*.la" | while read line; do echo -n "$line "; readlink $line; done | grep -v ".*\.la$"

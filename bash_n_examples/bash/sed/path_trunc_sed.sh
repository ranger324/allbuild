find -name "*@db@*.depident" | sed 's%[^/]*/%%'
find -name "*@db@*.depident" | sed 's%/[^/]\+$%%'

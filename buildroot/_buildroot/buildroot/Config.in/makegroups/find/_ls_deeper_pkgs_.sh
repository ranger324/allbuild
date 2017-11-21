find -mindepth 2 -type f -name "*.mk" | sort | sed -e 's%^\./%%' -e 's%[^/]*/%%' | grep '/' | sort

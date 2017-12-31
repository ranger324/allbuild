find -mindepth 1 -type f -printf '%P\n' | sed 's%\(.*\)/\([^/]\+\)$%\2 \1%' | LC_COLLATE=C sort

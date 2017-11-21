sh _remove_dep1.sh.sh
cut -d / -f 1 .rem_cache.tmp1.sort | sort -u > .rem_cache.tmp1.sort1
cut -d : -f 2 .rem_cache.tmp1.sort | sort -u > .rem_cache.tmp1.sort2
cat .rem_cache.tmp1.sort1 .rem_cache.tmp1.sort2 | sort -u > .rem_cache.tmp1.sort3

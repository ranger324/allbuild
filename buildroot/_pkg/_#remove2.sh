sh _remove_dep1.sh.sh
#cut -d / -f 1 .rem_cache.tmp1.sort | sort -u > .rem_cache.tmp1.sort1
#cut -d : -f 2 .rem_cache.tmp1.sort | sort -u > .rem_cache.tmp1.sort2
#cat .rem_cache.tmp1.sort1 .rem_cache.tmp1.sort2 | sort -u > .rem_cache.tmp1.sort3
OPKG=
DEPP=
while read line; do
    PKG=${line%%/*}
    DEP=${line##*:}
    if [ "$OPKG" != "$PKG" ]; then
	if [ -z "$OPKG" ]; then
	    DEPP="$DEP"
	else
	    echo "$OPKG/depends:$DEPP"
	    DEPP="$DEP"
	fi
	OPKG="$PKG"
    else
	[ -z "$DEPP" ] && DEPP="$DEP" || DEPP="$DEPP $DEP"
    fi
done < .rem_cache.tmp1.sort > .rem_cache.tmp1.sort4
[[ ! -z "$PKG" ]] && echo "$PKG/depends:$DEPP" >> .rem_cache.tmp1.sort4

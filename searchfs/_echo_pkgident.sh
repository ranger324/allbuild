sh _findarchive.sh | \
while read PKG VER EXT DIR; do
    if [ -z "$DIR" ]; then
	echo -ne "$PKG-$VER$EXT\n$PKG\n$VER\n" > "$PKG.pkgident"
    else
	echo -ne "$PKG-$VER$EXT\n$PKG\n$VER\n" > "$DIR/$PKG.pkgident"
    fi
done

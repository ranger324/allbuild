##sort -V
cat _pkgs.list | \
while read pkg; do
    pkgalias=
    if PKGALIASLINE=`grep " $pkg$" _pkgs_alias2.list`; then
        pkgalias=`echo "$PKGALIASLINE" | cut -d " " -f 1`
    fi

    if [ -z "$pkgalias" ]; then
        if PKGLINE=`grep "^$pkg:" _pkgdesc.txt`; then
            DESC=`echo "$PKGLINE" | cut -d ":" -f 2-`
            echo "$DESC" > $pkg.desc
        fi
    else
        if PKGLINE=`grep "^$pkgalias:" _pkgdesc.txt`; then
            DESC=`echo "$PKGLINE" | cut -d ":" -f 2-`
            echo "$DESC" > $pkg.desc
        fi
    fi
done

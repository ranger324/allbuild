    ##edit this file pkginfo.sh
    ##optional - create pkg.install
    ##DEPENDS list of dependencies (0 or more)
    ##DEPENDS="pkg1 pkg2"
    ##GRP - package group (2)
    ##GRP="group1 group2"
    ##DONTSTRIP 0 (or "" without value) or 1 ("1" value checked) - strip debug info or not
    ##DONTSTRIP=0

    ##pkginfo.sh
    #NAME=cpupower
    #VERSION=4.14.4
    #REV=1
    #SHORT_DESC="cpupower - Shows and sets processor power related values"
    #DEPENDS="pciutils"
    #GRP="base system"
    #PKG=$NAME
    #DONTSTRIP=

    #NAME=linux-R4.14
    #VERSION=4.14.4
    #REV=1
    #SHORT_DESC="Linux kernel and modules"
    #DEPENDS=""
    #GRP="base kernel"
    #PKG=$NAME
    #DONTSTRIP=1


    DESTROOT=binpkg
    PKGDEST=/dest

    source ./pkginfo.sh

    [ "$DONTSTRIP" != 1 ] && _strip $DESTROOT

    echo -n > pkg.deps
    for i in $DEPENDS; do
	echo "$i" >> pkg.deps
    done

    #make package info files
    mkdir -p $DESTROOT/var/lib/instpkg/local
    mkdir -p $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV
    mkdir -p $DESTROOT/var/lib/instpkg/local/.local
    ln -sf ../$PKG-$VERSION-$REV $DESTROOT/var/lib/instpkg/local/.local/$PKG
    SIZE=`du -sk $DESTROOT | grep -o "^[0-9]\+"`
    #write pkginfo
    echo -ne "NAME=$NAME\nVERSION=$VERSION\nREV=$REV\nDESC=\"$SHORT_DESC\"\nSIZE=$SIZE\nARCH=$(uname -m)\n" > $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/info
    #buildroot descriptions
    echo "$SHORT_DESC" > $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/desc@


    if [ -e pkg.distdeps ]; then
	sh /bin/_add_linefeed.sh pkg.distdeps
	cp pkg.distdeps $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/distdeps
	cat pkg.distdeps >> _scripts/$PKG.deps
    fi


    sort -u pkg.deps > $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/depends
    cat $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/depends | tr '\n' ' ' | \
	sed 's% $%%' > $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/depend@

    [ -z "$GRP" ] && GRP="unknown other"

    #write groups entry
    echo "$GRP" > $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/groups
    #copy install file
    [ -e pkg.install ] && cp -dp pkg.install $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/install
    #copy keepdirs file
    [ -e pkg.keepdirs ] && cp -dp pkg.keepdirs $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/keepdirs
    #find execs
    LS_EXECS=`sh /bin/_lsexecs.sh $DESTROOT | sort`
    [ ! -z "$LS_EXECS" ] && echo "$LS_EXECS" > $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/execs
    #find dirlinks
    LS_DIRLINKS=`sh /bin/_find_dirlinks.sh $DESTROOT | sort`
    [ ! -z "$LS_DIRLINKS" ] && echo "$LS_DIRLINKS" > $DESTROOT/var/lib/instpkg/local/$PKG-$VERSION-$REV/dirlinks


    (cd $DESTROOT; tar czf $PKGDEST/$PKG-$VERSION-$REV.tar.gz *)

    rm pkg.deps

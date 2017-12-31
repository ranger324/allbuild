#! /bin/sh
#gather dependencies

tempdir=`mktemp -d 2> /dev/null` || tempdir=/tmp/tmpdir$$
trap "rm -rf $tempdir" 0 1 2 5 15

[ -z "$1" ] && exit 1

basedep(){
while read line; do grep " $line " /var/lib/instpkg/depends.local.data; done < $tempdir/base
}

grep " $1 " /var/lib/instpkg/depends.local.data | cut -d " " -f 1  > $tempdir/base
touch $tempdir/base.old

while ! cmp $tempdir/base $tempdir/base.old &> /dev/null; do
    basedep | cut -d " " -f 1 > $tempdir/expand
    cat $tempdir/base >> $tempdir/expand
    cp $tempdir/base $tempdir/base.old
    sort -u $tempdir/expand > $tempdir/base
    echo -n > $tempdir/expand
done

cat $tempdir/base

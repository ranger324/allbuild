#! /bin/sh

[ -z "$1" ] && exit 1

grep "^$1" /var/lib/instpkg/packages.data | cut -d " " -f 3,4| tr " " - | \
while read line; do
    [ -e /home/packages/$line-i686.pkg.tar.gz ] && mv /home/packages/$line-i686.pkg.tar.gz /home/packages/tmp
done

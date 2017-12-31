#! /bin/bash

tempfile=`mktemp 2> /dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

for i in $(pacman -Sg core | cut -d " " -f 2); do
    if ! pacman -Q | grep -qw "$i"; then
	echo $i >> $tempfile
    fi
done

[ -s $tempfile ] && pacman -S `cat $tempfile`

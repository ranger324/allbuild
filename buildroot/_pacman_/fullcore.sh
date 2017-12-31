#! /bin/sh

PKGS=`LC_ALL=C pacman -Sl | grep -v "\[installed\]" | cut -d ' ' -f 2`
[ ! -z "$PKGS" ] && pacman -S $PKGS

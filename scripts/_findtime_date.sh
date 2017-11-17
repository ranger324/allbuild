#! /bin/sh

[ "$1" = "-n" ] && maxdepth="-maxdepth 1"
#find -mindepth 1 $maxdepth -printf "%Tx %p\n" | sort -n -r -t / -k 3 -k 1 -k 2
find -mindepth 1 $maxdepth -printf "%Ty%Tm%Td %p\n" | sort -n -r

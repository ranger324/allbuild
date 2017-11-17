line="/proc/123/exe"
FILE=${line##*/}
DIR=${line%/*}
#/proc/123/exe
A=${i/%\/exe/}
A=${i%/exe}

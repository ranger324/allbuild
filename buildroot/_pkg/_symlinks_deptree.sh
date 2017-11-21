cd .local
find -L -mindepth 1 -type d -printf "%P\n" > /_asd
sed -e '/\/\.depends$/d' -e 's%.*%&/%' /_asd | sort -V | tee /_asd2 | sed -e 's%/\.depends/%@%g' -e 's%/$%%' > /_asd3

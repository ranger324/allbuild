find -mindepth 1 -maxdepth 1 -type d ! -name ".local" | \
while read line; do
    mkdir $line/.depends
    for i in $(cat $line/depends); do
	ln -snf ../../$(basename $(readlink .local/$i)) $line/.depends/$i
    done
done

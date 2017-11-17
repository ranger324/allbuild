[ "$1" = "-n" ] && n_empty=1 && shift
[ -z "$1" ] && exit 1
EXT="$1"
#echo $DIR - if param then print files
find -mindepth 1 -maxdepth 1 -type d | sort | \
while read DIR; do
    if [ -z "$n_empty" ]; then
	(cd $DIR && find -type f -name "*.$EXT") | xargs echo $DIR
    else
	(cd $DIR && find -type f -name "*.$EXT") | xargs -r echo $DIR
    fi
done

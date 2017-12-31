
if [ "$1" = "-l" ]; then
    findlinks=1
    shift
fi

[ -z "$1" ] && DIR="." || DIR="$1"

[ ! -d "$DIR" ] && echo "No such directory" && exit 1

cd "$DIR"
[ "$?" != 0 ] && echo "Cannot change to directory" && exit 1

FIND_EXECS_DIRS="\
bin \
sbin \
usr/bin \
usr/sbin \
lib \
usr/lib \
usr/libexec \
"

if [ $findlinks ]; then
for i in $FIND_EXECS_DIRS; do
    (cd "$i" 2> /dev/null && sh /bin/_find_lib_non_sharedlib.sh -l) | sed "s%.*%$i/&%"
done
else
for i in $FIND_EXECS_DIRS; do
    (cd "$i" 2> /dev/null && sh /bin/_find_lib_non_sharedlib.sh) | sed "s%.*%$i/&%"
done
fi

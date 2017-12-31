FIND_EXECS_DIRS="\
bin \
sbin \
usr/bin \
usr/sbin \
lib \
usr/lib \
usr/libexec \
"

for i in $FIND_EXECS_DIRS; do
    (cd $i 2> /dev/null && sh /bin/_find_lib_non_sharedlib.sh) | sed "s%.*%$i/&%"
done

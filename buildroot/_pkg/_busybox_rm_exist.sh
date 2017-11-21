for i in `find -type l | xargs -r -i sh -c "basename {}"`; do
    _find_busybox_links | grep "/$i " | cut -d ' ' -f 1 | xargs -r -i sh -c 'echo {}; rm {}'
done

for i in `find -type l`; do
    ln -sf busybox-pw `basename "$i"`
done

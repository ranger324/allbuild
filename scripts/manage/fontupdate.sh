
[ ! -d /etc/X11/fontpath.d ] && exit 1
for i in /etc/X11/fontpath.d/*; do
    [ -e "$i" ] && cd "$i" && mkfontscale && mkfontdir
done
fc-cache

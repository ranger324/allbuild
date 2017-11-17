#! /bin/sh

[ `id -u` != 0 ] && exit 1

keepfiles="\
bookmarkbackups\n\
extensions\n\
extensions.ini\n\
extensions.sqlite\n\
localstore.rdf\n\
prefs.js\n\
"

if [ "$1" = "-r" ]; then
    [ ! -e /root/.mozilla/firefox/profiles.ini ] && exit 0
    eval `grep "Path=" /root/.mozilla/firefox/profiles.ini`
    allfiles=`ls -A /root/.mozilla/firefox/$Path`
    for i in $allfiles; do
	echo -ne "$keepfiles" | grep -q "^$(echo "$i" | sed 's/\./\\\./g')$" || rm -rf /root/.mozilla/firefox/$Path/$i
    done
    exit 0
fi

for iuser in `find /home -maxdepth 1 -mindepth 1 -type d -printf "%f\n"`; do
    if id -u $iuser > /dev/null 2>&1; then
	[ ! -e /home/$iuser/.mozilla/firefox/profiles.ini ] && continue
	eval `grep "Path=" /home/$iuser/.mozilla/firefox/profiles.ini`
	allfiles=`ls -A /home/$iuser/.mozilla/firefox/$Path`
	for i in $allfiles; do
	    echo -ne "$keepfiles" | grep -q "^$(echo "$i" | sed 's/\./\\\./g')$" || rm -rf /home/$iuser/.mozilla/firefox/$Path/$i
	done
    fi
done

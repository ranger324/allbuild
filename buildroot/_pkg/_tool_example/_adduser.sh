#busybox
delgroup man video
adduser -h /var/cat -g man -G users -s /bin/bash -D -H -u $(sh /bin/_get_next_user.sh 0) man
adduser man video

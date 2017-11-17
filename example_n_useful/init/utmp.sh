echo -n > /var/run/utmp
touch /var/log/wtmp >/dev/null 2>&1
chgrp utmp /var/run/utmp /var/log/wtmp >/dev/null 2>&1
chmod 0664 /var/run/utmp /var/log/wtmp >/dev/null 2>&1

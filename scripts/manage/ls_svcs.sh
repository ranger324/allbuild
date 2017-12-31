find /etc/runlevels -maxdepth 1 -type l | sort | while read svc; do
    echo "${svc##*/}"
    rc-service ${svc##*/} status
done

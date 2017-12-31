ftp -1 ftp -1 * /home/ftp - - Anonymous FTP User
avahi -1 avahi -1 * - - -
named -1 named -1 * /etc/bind - - BIND daemon
redis -1 redis -1 * /var/lib/redis /bin/false - Redis Server
sshd -1 sshd -1 * - - - SSH drop priv user
quagga -1 quagga -1 * - - - Quagga priv drop user
ftp -1 ftp -1 * /home/ftp - - Anonymous FTP User
- - input -1 * - - - Input device group
dbus -1 dbus -1 * /var/run/dbus - dbus DBus messagebus user
news -1 news -1 * - - - Leafnode2 daemon
mysql -1 nogroup -1 * /var/mysql - - MySQL daemon
mosquitto -1 nogroup -1 * - - - Mosquitto user
nslcd -1 nslcd -1 * - - - nslcd user
ejabberd -1 ejabberd -1 * /var/lib/ejabberd /bin/sh - ejabberd daemon
mysql -1 mysql -1 * /var/lib/mysql - - MySQL Server
tvheadend -1 tvheadend -1 * /home/tvheadend - video TVHeadend daemon
exim 88 mail 8 * - - - exim
pulse -1 pulse -1 * /var/run/pulse - audio,pulse-access
- - docker -1 * - - - Docker Application Container Framework
saned -1 saned -1 * /etc/sane.d - - Saned User
transmission -1 transmission -1 * /var/lib/transmission - transmission Transmission Daemon
- - input -1 * - - - Input device group
- - systemd-journal -1 * - - - Journal
systemd-bus-proxy -1 systemd-bus-proxy -1 * - - - Proxy D-Bus messages to/from a bus
systemd-journal-gateway -1 systemd-journal-gateway -1 * /var/log/journal - - Journal Gateway
systemd-journal-remote -1 systemd-journal-remote -1 * /var/log/journal/remote - - Journal Remote
systemd-journal-upload -1 systemd-journal-upload -1 * - - - Journal Upload
systemd-coredump -1 systemd-coredump -1 * /var/lib/systemd/coredump - - Core Dumper
systemd-network -1 systemd-network -1 * - - - Network Manager
systemd-resolve -1 systemd-resolve -1 * - - - Network Name Resolution Manager
systemd-timesync -1 systemd-timesync -1 * - - - Network Time Synchronization
squid -1 squid -1 * - - - Squid proxy cache
- - weston-launch -1 - - - - Weston launcher group
unscd -1 unscd -1 * - - - unscd user
upmpdcli -1 upmpdcli -1 * - - audio Upmpdcli MPD UPnP Renderer Front-End
postgres -1 postgres -1 * /var/lib/pgsql /bin/sh - PostgreSQL Server
rabbitmq -1 rabbitmq -1 * /var/lib/rabbitmq /bin/sh - rabbitmq-server daemon
_ntp -1 _ntp -1 * - - - Network Time Protocol daemon

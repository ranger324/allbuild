addgroup -g $(sh /bin/_get_next_group.sh 1000) ftp
addgroup -g $(sh /bin/_get_next_group.sh 1000) avahi
addgroup -g $(sh /bin/_get_next_group.sh 1000) named
addgroup -g $(sh /bin/_get_next_group.sh 1000) redis
addgroup -g $(sh /bin/_get_next_group.sh 1000) sshd
addgroup -g $(sh /bin/_get_next_group.sh 1000) quagga
addgroup -g $(sh /bin/_get_next_group.sh 1000) input
addgroup -g $(sh /bin/_get_next_group.sh 1000) dbus
addgroup -g $(sh /bin/_get_next_group.sh 1000) news
addgroup -g $(sh /bin/_get_next_group.sh 1000) nogroup
addgroup -g $(sh /bin/_get_next_group.sh 1000) nslcd
addgroup -g $(sh /bin/_get_next_group.sh 1000) ejabberd
addgroup -g $(sh /bin/_get_next_group.sh 1000) mysql
addgroup -g $(sh /bin/_get_next_group.sh 1000) tvheadend
addgroup -g $(sh /bin/_get_next_group.sh 1000) video
addgroup -g $(sh /bin/_get_next_group.sh 1000) mail
addgroup -g $(sh /bin/_get_next_group.sh 1000) pulse
addgroup -g $(sh /bin/_get_next_group.sh 1000) audio
addgroup -g $(sh /bin/_get_next_group.sh 1000) pulse-access
addgroup -g $(sh /bin/_get_next_group.sh 1000) docker
addgroup -g $(sh /bin/_get_next_group.sh 1000) saned
addgroup -g $(sh /bin/_get_next_group.sh 1000) transmission
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-journal
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-bus-proxy
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-journal-gateway
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-journal-remote
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-journal-upload
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-coredump
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-network
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-resolve
addgroup -g $(sh /bin/_get_next_group.sh 1000) systemd-timesync
addgroup -g $(sh /bin/_get_next_group.sh 1000) squid
addgroup -g $(sh /bin/_get_next_group.sh 1000) weston-launch
addgroup -g $(sh /bin/_get_next_group.sh 1000) unscd
addgroup -g $(sh /bin/_get_next_group.sh 1000) upmpdcli
addgroup -g $(sh /bin/_get_next_group.sh 1000) postgres
addgroup -g $(sh /bin/_get_next_group.sh 1000) rabbitmq
addgroup -g $(sh /bin/_get_next_group.sh 1000) _ntp
adduser -h /home/ftp -g 'Anonymous FTP User' -G ftp  -D -H -u $(sh /bin/_get_next_user.sh 1000) ftp
adduser   -G avahi  -D -H -u $(sh /bin/_get_next_user.sh 1000) avahi
adduser -h /etc/bind -g 'BIND daemon' -G named  -D -H -u $(sh /bin/_get_next_user.sh 1000) named
adduser -h /var/lib/redis -g 'Redis Server' -G redis -s /bin/false -D -H -u $(sh /bin/_get_next_user.sh 1000) redis
adduser  -g 'SSH drop priv user' -G sshd  -D -H -u $(sh /bin/_get_next_user.sh 1000) sshd
adduser  -g 'Quagga priv drop user' -G quagga  -D -H -u $(sh /bin/_get_next_user.sh 1000) quagga
adduser -h /home/ftp -g 'Anonymous FTP User' -G ftp  -D -H -u $(sh /bin/_get_next_user.sh 1000) ftp
adduser -h /var/run/dbus -g 'DBus messagebus user' -G dbus  -D -H -u $(sh /bin/_get_next_user.sh 1000) dbus
adduser dbus dbus
adduser  -g 'Leafnode2 daemon' -G news  -D -H -u $(sh /bin/_get_next_user.sh 1000) news
adduser -h /var/mysql -g 'MySQL daemon' -G nogroup  -D -H -u $(sh /bin/_get_next_user.sh 1000) mysql
adduser  -g 'Mosquitto user' -G nogroup  -D -H -u $(sh /bin/_get_next_user.sh 1000) mosquitto
adduser  -g 'nslcd user' -G nslcd  -D -H -u $(sh /bin/_get_next_user.sh 1000) nslcd
adduser -h /var/lib/ejabberd -g 'ejabberd daemon' -G ejabberd -s /bin/sh -D -H -u $(sh /bin/_get_next_user.sh 1000) ejabberd
adduser -h /var/lib/mysql -g 'MySQL Server' -G mysql  -D -H -u $(sh /bin/_get_next_user.sh 1000) mysql
adduser -h /home/tvheadend -g 'TVHeadend daemon' -G tvheadend  -D -H -u $(sh /bin/_get_next_user.sh 1000) tvheadend
adduser tvheadend video
adduser  -g 'exim' -G mail  -D -H -u $(sh /bin/_get_next_user.sh 1000) exim
adduser -h /var/run/pulse  -G pulse  -D -H -u $(sh /bin/_get_next_user.sh 1000) pulse
adduser pulse audio
adduser pulse pulse-access
adduser -h /etc/sane.d -g 'Saned User' -G saned  -D -H -u $(sh /bin/_get_next_user.sh 1000) saned
adduser -h /var/lib/transmission -g 'Transmission Daemon' -G transmission  -D -H -u $(sh /bin/_get_next_user.sh 1000) transmission
adduser transmission transmission
adduser  -g 'Proxy D-Bus messages to/from a bus' -G systemd-bus-proxy  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-bus-proxy
adduser -h /var/log/journal -g 'Journal Gateway' -G systemd-journal-gateway  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-journal-gateway
adduser -h /var/log/journal/remote -g 'Journal Remote' -G systemd-journal-remote  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-journal-remote
adduser  -g 'Journal Upload' -G systemd-journal-upload  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-journal-upload
adduser -h /var/lib/systemd/coredump -g 'Core Dumper' -G systemd-coredump  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-coredump
adduser  -g 'Network Manager' -G systemd-network  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-network
adduser  -g 'Network Name Resolution Manager' -G systemd-resolve  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-resolve
adduser  -g 'Network Time Synchronization' -G systemd-timesync  -D -H -u $(sh /bin/_get_next_user.sh 1000) systemd-timesync
adduser  -g 'Squid proxy cache' -G squid  -D -H -u $(sh /bin/_get_next_user.sh 1000) squid
adduser  -g 'unscd user' -G unscd  -D -H -u $(sh /bin/_get_next_user.sh 1000) unscd
adduser  -g 'Upmpdcli MPD UPnP Renderer Front-End' -G upmpdcli  -D -H -u $(sh /bin/_get_next_user.sh 1000) upmpdcli
adduser upmpdcli audio
adduser -h /var/lib/pgsql -g 'PostgreSQL Server' -G postgres -s /bin/sh -D -H -u $(sh /bin/_get_next_user.sh 1000) postgres
adduser -h /var/lib/rabbitmq -g 'rabbitmq-server daemon' -G rabbitmq -s /bin/sh -D -H -u $(sh /bin/_get_next_user.sh 1000) rabbitmq
adduser  -g 'Network Time Protocol daemon' -G _ntp  -D -H -u $(sh /bin/_get_next_user.sh 1000) _ntp

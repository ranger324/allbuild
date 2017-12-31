addgroup -g 1006 ftp
addgroup -g 1007 avahi
addgroup -g 1008 named
addgroup -g 1009 redis
addgroup -g 1001 sshd
addgroup -g 1010 quagga
addgroup -g 20 input
addgroup -g 1000 dbus
addgroup -g 1011 news
addgroup -g 65534 nogroup
addgroup -g 1012 nslcd
addgroup -g 1013 ejabberd
addgroup -g 1014 mysql
addgroup -g 1015 tvheadend
addgroup -g 28 video
addgroup -g 8 mail
addgroup -g 1002 pulse
addgroup -g 29 audio
addgroup -g 1004 pulse-access
addgroup -g 1016 docker
addgroup -g 1017 saned
addgroup -g 1005 transmission
addgroup -g 1018 systemd-journal
addgroup -g 1019 systemd-bus-proxy
addgroup -g 1020 systemd-journal-gateway
addgroup -g 1021 systemd-journal-remote
addgroup -g 1022 systemd-journal-upload
addgroup -g 1023 systemd-coredump
addgroup -g 1024 systemd-network
addgroup -g 1025 systemd-resolve
addgroup -g 1026 systemd-timesync
addgroup -g 1027 squid
addgroup -g 1003 weston-launch
addgroup -g 1028 unscd
addgroup -g 1029 upmpdcli
addgroup -g 1030 postgres
addgroup -g 1031 rabbitmq
addgroup -g 1032 _ntp
adduser -h /home/ftp -g 'Anonymous FTP User' -G ftp  -D -H -u 1005 ftp
adduser   -G avahi  -D -H -u 1006 avahi
adduser -h /etc/bind -g 'BIND daemon' -G named  -D -H -u 1007 named
adduser -h /var/lib/redis -g 'Redis Server' -G redis -s /bin/false -D -H -u 1008 redis
adduser  -g 'SSH drop priv user' -G sshd  -D -H -u 1001 sshd
adduser  -g 'Quagga priv drop user' -G quagga  -D -H -u 1009 quagga
adduser -h /home/ftp -g 'Anonymous FTP User' -G ftp  -D -H -u 1005 ftp
adduser -h /var/run/dbus -g 'DBus messagebus user' -G dbus  -D -H -u 1000 dbus
adduser dbus dbus
adduser  -g 'Leafnode2 daemon' -G news  -D -H -u 1010 news
adduser -h /var/mysql -g 'MySQL daemon' -G nogroup  -D -H -u 1011 mysql
adduser  -g 'Mosquitto user' -G nogroup  -D -H -u 1012 mosquitto
adduser  -g 'nslcd user' -G nslcd  -D -H -u 1013 nslcd
adduser -h /var/lib/ejabberd -g 'ejabberd daemon' -G ejabberd -s /bin/sh -D -H -u 1014 ejabberd
adduser -h /var/lib/mysql -g 'MySQL Server' -G mysql  -D -H -u 1011 mysql
adduser -h /home/tvheadend -g 'TVHeadend daemon' -G tvheadend  -D -H -u 1015 tvheadend
adduser tvheadend video
adduser  -g 'exim' -G mail  -D -H -u 1016 exim
adduser -h /var/run/pulse  -G pulse  -D -H -u 1002 pulse
adduser pulse audio
adduser pulse pulse-access
adduser -h /etc/sane.d -g 'Saned User' -G saned  -D -H -u 1017 saned
adduser -h /var/lib/transmission -g 'Transmission Daemon' -G transmission  -D -H -u 1018 transmission
adduser transmission transmission
adduser  -g 'Proxy D-Bus messages to/from a bus' -G systemd-bus-proxy  -D -H -u 1019 systemd-bus-proxy
adduser -h /var/log/journal -g 'Journal Gateway' -G systemd-journal-gateway  -D -H -u 1020 systemd-journal-gateway
adduser -h /var/log/journal/remote -g 'Journal Remote' -G systemd-journal-remote  -D -H -u 1021 systemd-journal-remote
adduser  -g 'Journal Upload' -G systemd-journal-upload  -D -H -u 1022 systemd-journal-upload
adduser -h /var/lib/systemd/coredump -g 'Core Dumper' -G systemd-coredump  -D -H -u 1023 systemd-coredump
adduser  -g 'Network Manager' -G systemd-network  -D -H -u 1024 systemd-network
adduser  -g 'Network Name Resolution Manager' -G systemd-resolve  -D -H -u 1025 systemd-resolve
adduser  -g 'Network Time Synchronization' -G systemd-timesync  -D -H -u 1026 systemd-timesync
adduser  -g 'Squid proxy cache' -G squid  -D -H -u 1027 squid
adduser  -g 'unscd user' -G unscd  -D -H -u 1028 unscd
adduser  -g 'Upmpdcli MPD UPnP Renderer Front-End' -G upmpdcli  -D -H -u 1029 upmpdcli
adduser upmpdcli audio
adduser -h /var/lib/pgsql -g 'PostgreSQL Server' -G postgres -s /bin/sh -D -H -u 1030 postgres
adduser -h /var/lib/rabbitmq -g 'rabbitmq-server daemon' -G rabbitmq -s /bin/sh -D -H -u 1031 rabbitmq
adduser  -g 'Network Time Protocol daemon' -G _ntp  -D -H -u 1032 _ntp

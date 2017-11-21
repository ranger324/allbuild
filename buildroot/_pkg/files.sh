[ ! -z "$1" ] && BUILDSYS="$1" || exit 1
mkdir -pv $BUILDSYS/{bin,boot,dev,etc,home,lib,mnt}
mkdir -pv $BUILDSYS/{proc,media,sbin,sys}
mkdir -pv $BUILDSYS/var/{lock,log,mail,run,spool}
mkdir -pv $BUILDSYS/var/{empty,opt,cache,lib/{misc,locate},local}
install -dv -m 0750 $BUILDSYS/root
install -dv -m 1777 $BUILDSYS{/var,}/tmp
mkdir -pv $BUILDSYS/usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv $BUILDSYS/usr/{,local/}share/{doc,info,locale,man}
mkdir -pv $BUILDSYS/usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv $BUILDSYS/usr/{,local/}share/man/man{1,2,3,4,5,6,7,8}
for dir in $BUILDSYS/usr{,/local}; do
  ln -sv share/{man,doc,info} $dir
done
ln -sv ../mail $BUILDSYS/var/spool/mail

cat > $BUILDSYS/etc/passwd << "EOF"
root::0:0:root:/root:/bin/bash
EOF

cat > $BUILDSYS/etc/group << "EOF"
root:x:0:
bin:x:1:
sys:x:2:
adm:x:3:
kmem:x:4:
tty:x:5:
tape:x:6:
floppy:x:7:
cdrom:x:8:
cdrw:x:9:
disk:x:10:
lp:x:11:
usb:x:12:
daemon:x:13:
utmp:x:14:
dialout:x:15:
audio:x:16:
video:x:17:
mail:x:18:
news:x:19:
uucp:x:20:
nogroup:x:21:
users:x:1000:
EOF

touch $BUILDSYS/var/run/utmp $BUILDSYS/var/log/{btmp,lastlog,wtmp}
chmod -v 664 $BUILDSYS/var/run/utmp $BUILDSYS/var/log/lastlog
chmod -v 600 $BUILDSYS/var/log/btmp

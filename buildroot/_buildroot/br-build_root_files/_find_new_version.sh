#wget https://kent.dl.sourceforge.net/project/reiser4/reiser4-for-linux-4.x/reiser4-for-4.13.0.patch.gz
#wget https://netcologne.dl.sourceforge.net/project/reiser4/reiser4-for-linux-4.x/reiser4-for-4.12.2.patch.gz
#wget https://netcologne.dl.sourceforge.net/project/reiser4/reiser4-for-linux-4.x/reiser4-for-4.11.0.patch.gz
#netcologne.dl.sourceforge.net
#wget https://sourceforge.net/projects/reiser4/files/reiser4-for-linux-4.x/reiser4-for-4.13.0.patch.gz/download
#wget https://sourceforge.net/projects/reiser4/files/reiser4-for-linux-4.x/reiser4-for-4.12.2.patch.gz/download
#wget https://sourceforge.net/projects/reiser4/files/reiser4-for-linux-4.x/reiser4-for-4.11.0.patch.gz/download


#can replace num with something
#tipical
#ver-alphabetic[_-]
#dmraid-1.0.0.rc16-3.tar.bz2
#ebtables-v2.0.10-4.tar.gz
#grep -o "[._-][[:digit:]._-]\+[._-]" _sites.lst

echo_ver()
{
local j pr_ver
for j in `seq $NUM_VER -1 1`; do
    if [ "$1" != "$j" ]; then
	eval pr_ver=\$V${j}
	echo -n "${pr_ver}."
    else
	echo -n "${2}."
    fi
done | sed 's/\.$//'
}

WGET_OPTS="--passive-ftp -nd -t 1 --timeout=5"

#http://downloads.sourceforge.net/project/hdparm/hdparm/hdparm-9.51.tar.gz
#FILE=hdparm-9.51.tar.gz
#EXT=.tar.gz
#SITE=http://downloads.sourceforge.net/project/hdparm/hdparm

#http://alpha.gnu.org/gnu/bc/bc-1.06.95.tar.bz2
#FILE=bc-1.06.95.tar.bz2
#EXT=.tar.bz2
#SITE=http://alpha.gnu.org/gnu/bc

#http://www.x.org/releases/individual/data/xkeyboard-config/xkeyboard-config-2.20.tar.bz2
#FILE=xkeyboard-config-2.20.tar.bz2
#EXT=.tar.bz2
#SITE=http://www.x.org/releases/individual/data/xkeyboard-config

#http://thekelleys.org.uk/dnsmasq/dnsmasq-2.76.tar.xz
#FILE=dnsmasq-2.76.tar.xz
#EXT=.tar.xz
#SITE=http://thekelleys.org.uk/dnsmasq

#https://cdn.kernel.org/pub/linux/bluetooth/bluez-5.47.tar.xz
#FILE=bluez-5.47.tar.xz
#EXT=.tar.xz
#SITE=https://cdn.kernel.org/pub/linux/bluetooth

#http://roy.marples.name/downloads/dhcpcd/dhcpcd-6.11.5.tar.xz
#FILE=dhcpcd-6.11.5.tar.xz
#EXT=.tar.xz
#SITE=http://roy.marples.name/downloads/dhcpcd

#http://ftp.midnight-commander.org/mc-4.8.19.tar.xz
#FILE=mc-4.8.19.tar.xz
#EXT=.tar.xz
#SITE=http://ftp.midnight-commander.org

#https://cdn.kernel.org/pub/software/utils/pciutils/pciutils-3.5.2.tar.xz
#FILE=pciutils-3.5.2.tar.xz
#EXT=.tar.xz
#SITE=https://cdn.kernel.org/pub/software/utils/pciutils

#http://www.freedesktop.org/software/polkit/releases/polkit-0.103.tar.gz
FILE=polkit-0.103.tar.gz
EXT=.tar.gz
SITE=http://www.freedesktop.org/software/polkit/releases

#http://ftpmirror.gnu.org/coreutils/coreutils-8.26.tar.xz
#FILE=coreutils-8.26.tar.xz
#EXT=.tar.xz
#SITE=http://ftp.gnu.org/gnu/coreutils

#FILE=reiser4-for-4.11.0.patch.gz
#EXT=.patch.gz
#SITE=https://netcologne.dl.sourceforge.net/project/reiser4/reiser4-for-linux-4.x



EXT_REGEX=`echo "$EXT" | sed 's%\.%\\\.%g'`
WO_EXT=`echo "$FILE" | sed "s%$EXT_REGEX$%%"`
VER=`echo "$WO_EXT" | sed 's%.*-%%'`
NAME=`echo "$WO_EXT" | sed 's%-[^-]\+$%%'`

VER_TEST=`echo "$VER" | tr '.' '0'`
if echo "$VER_TEST" | grep -q "[^[:digit:]]"; then
    echo "not numeric version"
    exit 1
fi

NUM_VER=`echo -n "${VER//[^.]/}" | wc -c`
NUM_VER=`expr $NUM_VER + 1`

VER_TMP=$VER

for i in `seq 1 $NUM_VER`; do
    eval V${i}=`echo "$VER_TMP" | sed 's/.*\.//'`
    VER_TMP=`echo "$VER_TMP" | sed 's/\.[^.]\+$//'`
done

i=1
while [ $i -le $NUM_VER ]; do
    VER_N_CHARNUM=
    eval VER_N=\$V${i}

    #:start:length
    if [ "${VER_N:0:1}" = 0 ]; then
	VER_N_CHARNUM=`echo -n "${VER_N}" | wc -c`
	VER_N=`expr $VER_N + 1`
	VER_N=`printf "%${VER_N_CHARNUM}d" $VER_N | tr ' ' 0`
    else
	VER_N=`expr $VER_N + 1`
    fi

    VER_DL=`echo_ver $i $VER_N`
    echo -n "wget $SITE/$NAME-$VER_DL$EXT "
    wget $WGET_OPTS $SITE/$NAME-$VER_DL$EXT > /dev/null 2>&1
    if [ "$?" != 0 ]; then
	echo "-"
	if [ $VER_N_CHARNUM ]; then
	    eval V${i}=`printf "%${VER_N_CHARNUM}d" 0 | tr ' ' 0`
	else
	    eval V${i}=0
	fi
	i=`expr $i + 1`
#
	CHANGED=1
#
#	echo "*$i*-"
    else
	echo "+"
	if [ $VER_N_CHARNUM ]; then
	    eval V${i}=`printf "%${VER_N_CHARNUM}d" $VER_N | tr ' ' 0`
	else
	    eval V${i}=$VER_N
	fi
	[ "$i" -gt 1 -a "$CHANGED" = 1 ] && i=`expr $i - 1` && CHANGED=
#
	#[ "$i" -gt 1 ] && i=`expr $i - 1`
#
#	echo "*$i*+"
    fi
done

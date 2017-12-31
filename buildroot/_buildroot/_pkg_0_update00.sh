#_VERSION_MINOR[[:space:]]\+=
#cp .config .config.set

grep "^BR2_PACKAGE_" .config.set | sed "s/=.*//" | \
while read pkg_entry; do
    find package -type f -name "Config.in" | xargs -r grep "config[[:space:]]\+$pkg_entry\|menuconfig[[:space:]]\+$pkg_entry"
done | sed -e 's%/[^/]*$%%' -e 's%^package/%%' | \
while read dir; do
#
    if ! echo "$processed" | grep -q "^${dir}$"; then
	pkgname=$(basename $dir)
	if [ -e package/$dir/${pkgname}.mk ]; then
	    echo package/$dir/${pkgname}.mk

	    echo "DIR=$dir" > /tmp/${pkgname}.1
	    grep "_VERSION[[:space:]]\+=\|_VERSION_MAJOR[[:space:]]\+=\|_VERSION_MINOR[[:space:]]\+=\|_VERSION_UPSTREAM[[:space:]]\+=" package/$dir/${pkgname}.mk >> /tmp/${pkgname}.1
	    sed -i -e "s/[()]//g" -e "s/[[:space:]]\+//g" /tmp/${pkgname}.1

	    sed -i "s/\(.*\)_VERSION=\(.*\)$/VERSION=\2/" /tmp/${pkgname}.1
	    if grep -q "\$call\|\$shell" /tmp/${pkgname}.1; then
		mv /tmp/${pkgname}.1 /tmp/${pkgname}.1_
	    fi

	fi
	[ -z "$processed" ] && processed="$dir" || processed=`echo -ne "$processed\n$dir"`
    fi
done

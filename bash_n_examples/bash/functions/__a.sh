LIBIDN_DEPENDENCIES='host-pkgconf $(if $(BR2_NEEDS_GETTEXT_IF_LOCALE),gettext) $(if $(BR2_PACKAGE_LIBICONV),libiconv)'
pattern1='\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)'

echo "$LIBIDN_DEPENDENCIES"
echo "$LIBIDN_DEPENDENCIES" | grep -o "$pattern1"

ifdeps=`echo "$LIBIDN_DEPENDENCIES" | grep -o "$pattern1"`
IFS1=$IFS
IFS=$'\n'
for line in $ifdeps; do
    PKGS=`echo "$line" | sed -e 's/[^,]\+,//' -e 's/)$//'`
    IFDEF=`echo "$line" | sed -e 's/\$([[:space:]]*if[[:space:]]\+\$(//' -e 's/)[[:space:]]*,.*//'`

    echo "$IFDEF"

    IFS2=$IFS
    IFS=$' ,\t'
    DEPIF=
    for i in $PKGS; do
	[ -z "$i" ] && continue
	case "$i" in
	    host-*)
		echo "$i"
	    ;;
	    *)
		echo "$i"
	    ;;
	esac
    done
    IFS=$IFS2
done
IFS=$IFS1

echo "$LIBIDN_DEPENDENCIES" | sed 's/\$([[:space:]]*if[[:space:]]\+[^,]\+,[^)]\+)//g'

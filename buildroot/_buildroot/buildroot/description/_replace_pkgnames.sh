echo -n > _pkgs_alias2.list

truncnames()
{
cat _pkgs_alias.list | grep "^$1" | \
while read pkg; do
    NAME=$(echo $pkg | sed "s/^$1//")
    echo "$NAME $pkg" >> _pkgs_alias2.list
done
}

truncnames xapp_
truncnames xdata_
truncnames xdriver_
truncnames xfont_
truncnames xlib_
truncnames xproto_
truncnames xserver_
truncnames xutil_

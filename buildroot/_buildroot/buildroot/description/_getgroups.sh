##GRP=`grep "package.*/$PKG/Config.in" _pkgs.group@@@@ | cut -d " " -f 1-2`
sed -i -e 's%/Config\.in$%%' -e 's% package/% %' -e 's% [^ ]\+/% %' _pkgs.group@@@@

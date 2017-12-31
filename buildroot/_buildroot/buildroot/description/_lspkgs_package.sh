find package -mindepth 2 -name "*.mk" -printf "%P\n" | sed -e 's%/[^/]\+$%%' -e 's%^.\+/%%' | sort > _pkgs.list

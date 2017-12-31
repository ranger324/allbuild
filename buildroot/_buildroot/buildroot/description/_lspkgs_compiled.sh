ls _scripts/*.deps | sed -e 's%\.deps$%%' -e 's%.*/%%' | sort > _pkgs.list

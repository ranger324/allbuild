#(grep "^#[^#]\+#depend@#" data | grep " zlib ";
#grep "^#[^#]\+#depend@#" data | grep " ncurses ") | sort -u

grep "^#[^#]\+#depend@#" data | grep -e " zlib " -e " ncurses "

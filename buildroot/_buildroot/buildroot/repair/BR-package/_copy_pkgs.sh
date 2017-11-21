find -mindepth 1 -maxdepth 1 -type d | while read line; do cp -Rdp $line ~/a/buildroot-2017.05-rc2-patch/package; done

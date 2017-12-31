#sh ./_grep_dep4.sh syslog-ng zlib
#sh ./_grep_dep4.sh syslog-ng zlib xserver_xorg-server
sh ./_grep_dep4.sh.tmp.sh $(cd /dest; ls *.tar.gz | rev | cut -d - -f 3- | rev)

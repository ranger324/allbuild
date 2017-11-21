#set +e

sh _#remove6.sh $(cd /dest; ls *.tar.gz | rev | cut -d - -f 3- | rev)

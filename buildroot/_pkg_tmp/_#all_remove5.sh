#set +e

sh _#remove5.sh $(cd /dest; ls *.tar.gz | rev | cut -d - -f 3- | rev)

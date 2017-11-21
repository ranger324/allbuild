sh ./_grep_dep4.sh $(cd /dest; ls *.tar.gz | rev | cut -d - -f 3- | rev)

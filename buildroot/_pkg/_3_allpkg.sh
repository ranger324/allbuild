sh ./_remove_dep3.sh $(cd /dest; ls *.tar.gz | rev | cut -d - -f 3- | rev)

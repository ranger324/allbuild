cd /dest
ls *.tar.gz | rev | cut -d - -f 3- | rev | sort | tee /_a | sort -u > /_b
comm -23 /_a /_b

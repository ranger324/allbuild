export LC_COLLATE=C
echo -n > ../data

find -L -type f -printf "%P\n" | sed "s%/info$%/!info%" | sort | \
while read file; do
#echo $file
    tmpvar=$(echo "$file" | sed "s%/!info$%/info%")
    if [ "$file" != "$tmpvar" ]; then
    file=$tmpvar
    source $file
    fi
    #VERSION=
    #REV=
    #echo "$file" >> ../data
    PKG=$(echo "$file" | sed "s%/.*%%")
    INF=$(echo $file | sed "s%.*/%%")
    PKGID=`readlink $PKG | sed "s%^\.\./%%"`
#    sed "s%.*%#$PKG#$INF#&%" $file >> ../data
#    echo "#$PKG#$INF#" >> ../data
#    echo "#$PKG#$INF#$(cat $file)" >> ../data
#    sed "s%.*%#$PKG#$INF#&%" $file >> ../data



    case $INF in

    depend@)
    if [ "$(stat -c '%s' $file)" = 0 ]; then
    echo "#$PKG#$INF#$PKGID#$VERSION#$REV#" >> ../data
    else
    echo "#$PKG#$INF#$PKGID#$VERSION#$REV# $(cat $file) " >> ../data
    fi
    ;;

    depends)
    if [ "$(stat -c '%s' $file)" = 0 ]; then
    echo "#$PKG#$INF#$PKGID#$VERSION#$REV#" >> ../data
    else
    sed "s%.*%#$PKG#$INF#$PKGID#$VERSION#$REV#&%" $file >> ../data
    fi
    ;;

    groups)
    sed "s%.*%#$PKG#$INF#$PKGID#$VERSION#$REV#&%" $file >> ../data
    ;;

    info)
    sed "s%.*%#$PKG#$INF#$PKGID#$VERSION#$REV#&%" $file >> ../data
#    grep -v "^DESC=" $file | sed "s%.*%#$PKG#$INF#&%" >> ../data
    ;;

    esac
done

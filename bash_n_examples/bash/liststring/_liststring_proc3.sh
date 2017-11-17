echo -ne "a c df\na d a a\n a f f d a\n"
echo
OIFS=$IFS
IFS=$'f'
echo -ne "a c df\na d a a\n a f f d a\n" | while read -r str; do echo "*$str*"; done
echo
echo -ne "a c df\na d a a\n a f f d a\n" | while read -r -d "$IFS" str; do echo "*$str*"; done
echo
echo -ne "a c df\na d a a\n a f f d a\n" | while read -r str1 str2; do echo "*$str1*"; echo "*$str2*"; done
echo
echo -ne "a c df\na d a a\n a f f d a\n" | while read -r -d "$IFS" str1 str2; do echo "*$str1*"; echo "*$str2*"; done
IFS=$OIFS

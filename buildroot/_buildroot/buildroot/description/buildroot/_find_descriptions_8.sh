##IFS not to read "words" without spaces
IFS=
printline=
cat desc2 | \
while read -r line; do
case "$line" in
---*/Config.in*)
    PKG=`echo "$line" | sed -e 's%^---%%' -e 's%/.*%%'`
;;
*)
    echo "$line" | sed 's/^	  //' >> $PKG.desc@
;;
esac
done

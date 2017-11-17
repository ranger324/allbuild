A=text
for i in $(seq 400); do
    PKG=`echo "$A" | sed 's/xt$//'`
    echo $PKG
done

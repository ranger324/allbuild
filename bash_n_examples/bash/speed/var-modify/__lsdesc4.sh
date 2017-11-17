A=text
for i in $(seq 400); do
    PKG=${A%xt}
    echo $PKG
done

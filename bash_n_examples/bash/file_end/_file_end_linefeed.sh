echo "asd" > asd
tail -c 1 asd | od -x | head -n 1 | cut -d ' ' -f 2
SIZE=`stat -c %s asd`
echo `od -v -A n -t x1 -N 1 -j $(expr $SIZE - 1) asd`

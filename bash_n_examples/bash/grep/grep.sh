
A="$(echo -ne "ff\ngg\nhh\n")"; echo -ne "aa\nbb\nggg\n" | grep -F "$A"
echo -ne "ff\ngg\nhh\n" > grep.lst
echo -ne "aa\nbb\ngg\n" | grep -f grep.lst

echo -ne "^b\n^gg$\nhh\n" > grep.lst
echo -ne "aa\nbb\ngg\n" | grep -f grep.lst

echo -ne "^b\n^gg$\nhh\n" > grep.lst
echo -ne "aa\nbb\ngg\n" | grep -f grep.lst

echo -ne "^b\n^gg$\nhh\naa\n" > grep.lst
echo -ne "aa\nbb\ngg\n" | grep -f grep.lst

echo -ne "gg\n" > grep2.lst
echo -ne "aa\nbb\ngg\n" | grep -v -f grep2.lst

#match line match ^..$
echo -ne "gg\n" > grep2.lst
echo -ne "aa\nbb\ngg\n" | grep -v -x -f grep2.lst

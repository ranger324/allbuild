echo -ne "a\nb\nc\n" | sed '1~1p'
echo
echo -ne "a\nb\nc\n" | sed '2p'
echo
echo -ne "a\nb\nc\n" | sed -n '2p'
echo -ne "a\nb\nc\n" | sed -n '2!p'
echo
echo -ne "a\nb\nc\n" | sed -n '1,+1p'
echo
echo -ne "a\nb\nc\n" | sed '1,+1p'
echo
echo -ne "a\nb\nc\n" | sed '1,3p'
echo
echo -ne "a\nb\nc\n" | sed '2s/.*/asd/'
echo -ne "a\nb\nc\n" | sed -n '2s/.*/asd/p'
echo -ne "a\nb\nc\n" | sed -n '2!s/a/1/gp'
echo
echo -ne "a\nb\nc\n" | sed -n -e '1,2p' -e '/a/p'
echo
echo -ne "a\nb\nc\n" | sed -n -e '1,2p' -n -e '/a/d'

echo -ne "a\nb\nc\n" | sed -n -e '1,2p' -n -e '/a/!d'
echo -ne "a\nb\nc\n" | sed -e '1d'
echo -ne "a\nb\nc\n" | sed -e '/a/d'

echo -ne "aa\nbb\ncc\n" | sed -e '/aa/c11'

echo -ne "a\nb\nc\n" | sed -n -e '/.*a.*/p'

echo -ne "a\nb\nc\n" | sed -n -e '/.*a.*/!p'
echo -ne "aa\nbb\ncc\n" | sed -n -e 's/.*\(aa\).*/\1/p'

echo -ne "a\nb\nc\n" | sed '2ax'

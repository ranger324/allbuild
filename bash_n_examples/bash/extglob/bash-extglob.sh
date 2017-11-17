shopt -s extglob
A="ASASDD-D-F-G"
echo 1 ${A//S+([A-Z])-}
echo 2 ${A//S*([A-Z])-}
##:(pattern) zero or one occurrences of the given patterns
##*(pattern) zero or more occurrences of the given patterns
##+(pattern) one or more occurrences of the given patterns
##@(pattern) one of the given pattern
##!(pattern) anything except one of the given patterns
echo 3 ${A/D*([A-Z-])-/__}
echo 4 ${A/%-*([GH])/-ES}
echo 5 ${A/%-*([GH])/}

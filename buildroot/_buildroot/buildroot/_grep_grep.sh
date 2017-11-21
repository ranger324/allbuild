echo "****"
echo -ne "A\nB2\nC3\nCR\nCE\nRC\nEC\nBBB\nDEA\n\$\nBR\n"
echo "**"
echo '^(?=^((?![CE]).)*$)[A-Z]+$'
echo "**"
echo -ne "A\nB2\nC3\nCR\nCE\nRC\nEC\nBBB\nDEA\n\$\nBR\n" | grep -P '^(?=^((?![CE]).)*$)[A-Z]+$'
echo "****"
echo -ne "A\nB2\nC3\nCR\nCE\nRC\nEC\nBBB\nDEA\n\$\nBR\n"
echo "**"
echo '(?=^((?![CE]).)*$)[A-Z]'
echo "**"
echo -ne "A\nB2\nC3\nCR\nCE\nRC\nEC\nBBB\nDEA\n\$\nBR\n" | grep -P '(?=^((?![CE]).)*$)[A-Z]'

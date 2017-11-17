
set -- -ne "1\n2\n"
echo "$*"
echo
echo "##"
echo
echo "$@"
echo
echo "##"
echo
echo "-ne 1\\\\n2\\\\n"
echo
echo "##"
echo
set -- -ne "1\\\\n2\\\\n"
echo "$@"
echo
echo "##"
echo
echo "$@" | sed 's/\\n/_/g'
echo
echo "##"
echo
echo "$*" | sed 's/\\n/_/g'
echo
echo "##"
echo

#multiple patterns "and" with any order
sed -e '/free/!d' -e '/can/!d' config.guess
#or pattern print lines
sed -e '/free/b' -e '/can/b' -e d config.guess

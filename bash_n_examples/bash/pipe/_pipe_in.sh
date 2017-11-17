echo asd | if [ -p /dev/stdin ]; then while read var; do echo $var; done < /dev/stdin; fi

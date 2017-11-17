[ -z "$1" ] && exit 1
F=$1
for i in *.${F}_; do mv $i `echo ${i} | sed "s/_$//"`; done

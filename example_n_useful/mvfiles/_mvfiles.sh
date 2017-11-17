[ -z "$1" ] && exit 1
F=$1
for i in *.${F}; do mv $i ${i}_; done

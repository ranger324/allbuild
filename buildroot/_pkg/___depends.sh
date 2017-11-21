for i in */depends; do echo $i; DIR=$(echo $i | sed 's%/.*%%'); cat $i | tr '\n' ' ' | sed 's% $%%' > $DIR/depend@; done

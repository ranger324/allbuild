find -type l | while read line; do LNK=$(readlink $line | sed 's%/lib64/%/lib/%g'); ln -sf $LNK $line; done

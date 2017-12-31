mkdir .local
ls */info | xargs grep "^NAME=" | sed -e 's%/info:NAME=% .local/%' -e 's%.*%../&%' | while read target link; do ln -sf $target $link; done

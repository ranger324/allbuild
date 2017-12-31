ls */install 2> /dev/null | xargs grep "^adduser \|^addgroup " | cut -d '/' -f 1 | sort -u | xargs -r -i sh -c 'source {}/install; pre_install'

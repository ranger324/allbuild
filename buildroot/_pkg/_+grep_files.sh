#while ... faster than xargs -i
time ls */depends | while read line; do grep -q "^zlib$" $line && echo $line; done
##time ls */depends 2> /dev/null | xargs -r -i sh -c 'grep -q "^zlib$" {} && echo {}'

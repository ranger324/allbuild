shuf -i 100-999 | tr -d '\n' | dd bs=512 count=1 2> /dev/null

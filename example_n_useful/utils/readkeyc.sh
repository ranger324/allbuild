A=`./readkeyc`
if [ "$A" = "M-C" ]; then
    B=`./readkeyc`
    echo "$B"
else
    echo "$A"
fi

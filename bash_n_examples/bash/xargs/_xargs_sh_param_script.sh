_findbin | xargs -r -i sh -c 'A="Type:"; readelf -h {} | grep -q "$A.*EXEC" && echo {}'

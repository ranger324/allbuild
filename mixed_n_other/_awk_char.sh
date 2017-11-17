#printf a1 | awk -niord '$0=chr("0x"RT)' RS=.. ORS= | od -tx1
printf a1 | awk -niord '$0=chr("0x"RT)' RS=.. ORS=
echo
echo $'\xc2\xa1'
#disable utf
echo 5a | sha256sum | awk -bniord 'RT~/\w/,$0=chr("0x"RT)' RS=.. ORS= > data1
#echo
echo 5a | sha256sum | awk -niord 'RT~/\w/,$0=chr("0x"RT)' RS=.. ORS= > data2
#echo 5a | sha256sum

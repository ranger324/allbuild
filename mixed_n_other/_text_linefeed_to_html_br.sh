cat mail.txt | tr '\n' '#' > mail.txt2
sed -i 's/#/<br>/g' mail.txt2

sh /bin/_first_nic.sh | grep "^[[:space:]]\+inet " | while read A IP REST; do echo "$IP"; done

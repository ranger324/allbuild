NIC=`ip addr | grep "^[0-9]\+:" | grep -v "^[0-9]\+: lo:" | grep " state UP " | head -n 1 | cut -d ' ' -f 2 | tr -d :`
if [ ! -z "$NIC" ]; then
    ip addr show $NIC
fi

start-stop-daemon -S -b -x sh -- -c "exec dmesg -w > /var/log/dmesg.log"

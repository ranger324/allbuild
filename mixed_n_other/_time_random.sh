#date +%s%N | cut -b 11-20
while true; do sleep 0.1; date +%s%N | cut -b 13-20; done

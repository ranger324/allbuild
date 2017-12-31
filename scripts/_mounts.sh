#replace \040 " "
cat /proc/mounts | cut -d ' ' -f 2 | sed -e 's%\\040% %g' -e 's%.*%*&*%'

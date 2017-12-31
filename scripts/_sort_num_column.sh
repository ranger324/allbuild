blkid | sort -R | sed 's%^/dev/sda%/dev/sda :%' | sort -t : -k 1,1 -k 2n

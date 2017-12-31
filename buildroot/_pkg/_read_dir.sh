
#echo 90 > /proc/sys/vm/swappiness
#default 60
#low - keep programs in memory
#high - keep more cache
#find /var/lib/instpkg/local -type f | xargs -r cat > /dev/null
#sync to ramdisk
vmtouch -dl /var/lib/instpkg/local
#find /var/lib/instpkg/local -type f | xargs -r readahead

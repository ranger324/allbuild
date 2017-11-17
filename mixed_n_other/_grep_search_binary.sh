#A=$'\x0A'; grep --byte-offset --only-matching -U "$A" kernel.mkfs
A=$'\x0A'; grep -b -o -UP "\x0a" kernel.mkfs
A=$'\x0A'; grep -b -UP "\x0a" kernel.mkfs

#line byte offset
A=$'a'; grep -b "a" kernel.mkfs
#pattern byte offset
A=$'a'; grep -bo "a" kernel.mkfs

#A=$'\x44\x55'; grep --byte-offset --only-matching "$A" kernel.mkfs | head -n -1
#A=$'\x44\x55'; grep --byte-offset --only-matching "$A" kernel.mkfs | head -n -1 | cut -d ':' -f 1
#grep -obUaP "\x00\x00" kernel.mkfs
#grep -obUaP "\x00\x1e" kernel.mkfs
#grep -obUaP "\x07P8" kernel.mkfs
#binwalk -R "\x44\x55" kernel.mkfs
#binwalk -R "\x0a\x00" kernel.mkfs
#grep -c $'\x0a' kernel.mkfs

#grep -bo $'\x0a' kernel.mkfs

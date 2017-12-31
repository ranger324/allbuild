#find -type l -o -type f -printf "%TY/%Tm/%Td %TT %m %P\n" | LC_COLLATE=C sort
cd /etc
find -type l -o -type f -printf "%TY/%Tm/%Td %TT %m %g %u %P\n" | LC_COLLATE=C sort -k 4

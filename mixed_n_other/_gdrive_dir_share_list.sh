#read file sections - key word to key word
wget -q https://drive.google.com/open?id=0Bz04AqheEMm9Rmh0ZFZqZmNYMDA -O gdrive.cont

grep "<script>window\['_DRIVE_ivd'\] = " gdrive.cont | sed -e "s#.*<script>window\['_DRIVE_ivd'\] = ##" -e "s#'; if (.*##" > gdrive1.tmp
##\x22\x5d\n,\x22 \x22
hexdump -ve '1/1 "%.2X"' gdrive1.tmp | sed 's/5C7832325C7835645C6E2C5C783232/0A/g' | xxd -r -p > gdrive2.tmp
tail -n +2 gdrive2.tmp | sed 's/\\.*//'

#tail -n +2 gdrive2.tmp | hexdump -ve '1/1 "%.2X"' | sed 's/5C783232/0A/g' | xxd -r -p > gdrive3.tmp
#5C7832325C7835645C6E2C5C783232
#0A
#23
#5C783232
#0A

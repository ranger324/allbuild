PRUNEPATHS='-path ./media -o -path ./mnt -o -path ./dev -o -path ./proc -o -path ./sys -o -path ./root -o -path ./home -o -path ./tmp -o -path ./var -o -path ./run'
find \( $PRUNEPATHS \) -prune -o -type f -printf "%s %P\n"

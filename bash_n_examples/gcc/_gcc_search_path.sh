gcc -print-search-dirs | awk '/^libraries:/' | sed -e "s/^libraries://" -e 's|=/|/|g'

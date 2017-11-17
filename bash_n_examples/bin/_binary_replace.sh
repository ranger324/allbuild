hexdump -ve '1/1 "%.2X"' file.sh | sed 's/E29482/23/g' | xxd -r -p > new_updated

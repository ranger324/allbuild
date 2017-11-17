gcc -nostdlib -nostartfiles stubstart.S helloworld.o pdclib.a -o helloworld.so
as -gstabs -o stubstart.o stubstart.S
objdump -d stubstart.o
gcc -fPIC -c helloworld.c -o helloworld.o
gcc -nostdlib helloworld.o pdclib.a -shared -o helloworld.so

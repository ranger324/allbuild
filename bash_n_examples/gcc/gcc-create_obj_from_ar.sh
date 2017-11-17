/tools/bin/gcc -m32 -nostdlib -nostartfiles -r \
 -Wl,-d -Wl,--whole-archive libc_pic.a -o libc_pic.o
ar -q libc2.a libc_pic.o

CFLAGS=-O2 -D_POSIX_SOURCE -m32
#CFLAGS=-O2 -D_POSIX_SOURCE
LDFLAGS=-m32 -Xlinker "--oformat=elf32-i386" -static
$(LD) --oformat elf32-i386 -r -b binary -o $@ $<
	$(LD) $(LDFLAGS) -Bsymbolic $(LD_PIE) -E --hash-style=gnu -T $(LDSCRIPT) -M -o $@ $< \
#		--start-group $(LIBS) $(subst $(*F).elf,lib$(*F).a,$@) --end-group \
		--start-group $(LIBS) $(subst $(*F).elf,lib$(*F).a,$@) --end-group --no-dynamic-linker \
		> $(@:.elf=.map)
#/tools/bin/x86_64-pc-linux-gnu-gcc
#	valac -D NULL=0 $^ -C

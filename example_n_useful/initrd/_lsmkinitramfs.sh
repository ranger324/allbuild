cd /lib/modules/`uname -r`/kernel
find drivers -mindepth 1 -maxdepth 1 ! -path "drivers/gpu" | sed 's%^drivers/[a-z0-9]\+$%& \\%'

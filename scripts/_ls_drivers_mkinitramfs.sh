
cd /lib/modules/`uname -r`/kernel
if [ -z "$1" ]; then
    find drivers -mindepth 1 -maxdepth 1 ! -path "drivers/gpu" | sed 's%^drivers/[a-z0-9]\+$%& \\%'
else
    find drivers -mindepth 1 -maxdepth 1 ! -path "drivers/$1" | sed 's%^drivers/[a-z0-9]\+$%& \\%'
fi

[ ! -d /run/media/$(whoami) ] && exit 1
cd /run/media/$(whoami)
find -maxdepth 1 -mindepth 1 -type d -print0 | xargs -r -0 -i umount {}
